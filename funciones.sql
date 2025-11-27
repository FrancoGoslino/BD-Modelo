-- =================================================================================================================================
-- 														FUNCIONES
-- ===============================================================================================================================
-- ------------------------------ STOCK DE PRODUCTOS ------------------------------
DELIMITER //
CREATE FUNCTION fn_stock_producto(
    nombre1 varchar(75)
    )
RETURNS INT
NOT DETERMINISTIC
BEGIN
	Declare stock int default 0;
    set stock = (select cantidad from producto where nombre1 = producto.nombre);
    return stock;
END //
DELIMITER ;

 select fn_stock_producto ("Casco de seguridad industrial");
  select* from producto;
-- ------------------------------ -- ------------------------------ -- ------------------------------ 
-- ------------------------------ CALCULAR NUEVO STOCK DE PRODUCTOS ------------------------------
/*											fuera de uso
DELIMITER //
CREATE FUNCTION fn_modif_stock_producto(
    nombre1 varchar(75),
    cantidad int
    )
RETURNS INT
NOT DETERMINISTIC
BEGIN
	Declare stock int default 0;
    declare stock_actualizado int DEFAULT 0;
    
    select cantidad into stock from producto where nombre = nombre1;
    set stock_actualizado = stock - cantidad;
    
    return stock_actualizado;
END //
DELIMITER ;
*/
-- ------------------------------ -- ------------------------------ -- ------------------------------ 
-- ------------------------------ VERIFICA ESTADO DE UN PAQUETE ------------------------------
DELIMITER //
CREATE FUNCTION fn_estado_actual_paquete(
	p_nombre VARCHAR(75)
)
RETURNS VARCHAR(20)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE v_estado VARCHAR(20);
    SELECT ee.estado INTO v_estado
    FROM historial_envio he
    JOIN envio e ON he.id_envio = e.id_envio
    JOIN paquete p ON e.id_paquete = p.id_paquete
    JOIN estado_envio ee ON he.id_estado = ee.id_estado
    WHERE p.nombre = p_nombre
    ORDER BY he.fecha_cambio DESC
    LIMIT 1;
    
    RETURN v_estado;
END//
DELIMITER ;
-- -------------------- corremos el proceso con datos de prueba --------------------
SELECT fn_estado_actual_paquete('Paquete_001');



-- ------------------------------ -- ------------------------------ -- ------------------------------ 
-- ------------------------------ CALCULAR PRECIO DE UNA COMPRA ------------------------------
-- HANDLER para determinar si el stock > venta
DELIMITER //

CREATE FUNCTION fn_precio_compra(
    p_producto VARCHAR(75),
    p_cantidad INT
)
RETURNS DECIMAL(20,2)
NOT DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE v_precio DECIMAL(20,2) DEFAULT 0.00;
    DECLARE v_stock INT DEFAULT 0;
    DECLARE v_precio_final DECIMAL(20,2) DEFAULT 0.00;
    
	DECLARE exit_stock_insuficiente CONDITION FOR SQLSTATE '45000';
    DECLARE exit handler for exit_stock_insuficiente

    BEGIN
    SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Stock insuficiente para realizar la compra';
    END;

    SELECT precio_unitario, cantidad INTO v_precio, v_stock FROM producto
     WHERE nombre = p_producto LIMIT 1;
    
    IF p_cantidad > v_stock THEN 
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Stock insuficiente para realizar la compra';
    else
         SET v_precio_final = p_cantidad * v_precio;
    END IF;
    
    RETURN v_precio_final;
END //
DELIMITER ;
-- -------------------- corremos el proceso con datos de prueba --------------------
			select fn_precio_compra ("Casco de seguridad industrial",2);

-- ------------------------------ -- ------------------------------ -- ------------------------------ 



-- =================================================================================================================================
-- 														TRIGGERS
-- ===============================================================================================================================
-- ------------------------------ AUDITORIA - ACTUALIZACION DE STOCK ------------------------------
    
DELIMITER //
create trigger trg_stock_producto_audit
after update on producto
FOR EACH ROW
BEGIN
    IF OLD.cantidad != NEW.cantidad THEN
        INSERT INTO actualizacion_stock_audit (
        id_producto,
		empleado,
		stock_anterior,
		stock_nuevo,
		fecha_modificacion 
	) VALUES (NEW.id_producto,
			  CURRENT_USER(), 
			  OLD.cantidad,
              NEW.cantidad,
              CURRENT_TIMESTAMP()
	);
    END IF;
END;
//
DELIMITER ;
-- -------------------- verificacion de los datos -------------------- 
			UPDATE producto SET cantidad = 90
				WHERE id_producto = 1;
			
            SELECT * FROM actualizacion_stock_audit;




-- ==================================================================================================================
-- 														STORED PROCEDURE
-- ==================================================================================================================
-- ------------------------------ REGISTRO DE COMPRAS ------------------------------
-- Registra COMPRA
-- Actualiza tabla intermedia PRODUCTO_HAS_COMPRA
-- Modifica stock en PRODUCTO
DELIMITER //
CREATE PROCEDURE sp_registrar_compra (
    IN p_usuario VARCHAR(75),
    IN p_producto VARCHAR(75),
    IN p_cantidad INT,
    OUT p_total DECIMAL(20,2)
)
BEGIN	
	declare v_usuario int;
	declare v_fecha_compra datetime;
    declare v_id_nueva_compra int;
    declare v_id_producto int;
    declare v_stock_proyectado int;
    
-- captura errores por usuario o producto inexistente
	DECLARE EXIT HANDLER FOR NOT FOUND
	BEGIN
	  ROLLBACK;
	  SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'No se encontró el usuario o producto';
	END;
-- captura errores generales sql
    DECLARE exit handler for SQLEXCEPTION
    BEGIN
    ROLLBACK;
    SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error durante el registro. Revise los datos y vuelva a intentar.';
    END;
    
    START TRANSACTION;
    set v_fecha_compra = now();
    set v_usuario = (select id_usuario from usuario where nombre = p_usuario);
    set p_total = fn_precio_compra(p_producto, p_cantidad);

		INSERT INTO compra (id_usuario, precio_total, dia_compra) 
			values (v_usuario, p_total, v_fecha_compra);
		
		set v_id_nueva_compra  = last_insert_id();
		set v_id_producto = (select id_producto from producto where nombre = p_producto);
		
		INSERT INTO producto_has_compra (id_compra, id_producto, cantidad)
			values (v_id_nueva_compra, v_id_producto, p_cantidad);
			
		UPDATE producto SET cantidad = cantidad - p_cantidad
			WHERE id_producto = v_id_producto;
	COMMIT;
END //
DELIMITER ;
-- -------------------- corremos el proceso con datos de prueba --------------------
			call sp_registrar_compra('Alejandro','Casco de seguridad industrial',4,@total);
			SELECT @total;

-- -------------------- verificacion de los datos -------------------- 
-- JOIN une tabla base + tabla relacionada ON condición de igualdad --

			SELECT c.id_compra, u.nombre AS usuario, p.nombre AS producto,
			  phc.cantidad,
			  c.precio_total, c.dia_compra
			FROM compra c
			JOIN producto_has_compra phc ON c.id_compra = phc.id_compra
			JOIN producto p ON phc.id_producto = p.id_producto
			JOIN usuario u ON c.id_usuario = u.id_usuario
			WHERE u.nombre = 'Alejandro'
			ORDER BY c.dia_compra DESC
			LIMIT 5;
            
            select * from producto;
            -- update producto set cantidad = 120 where id_producto = 1;

-- ------------------------------ -- ------------------------------ -- ------------------------------ 
-- ------------------------------ CEACION DE PAQUETES ------------------------------
-- sp_crear_paquete crea el paquete para la compra seleccionada.
DELIMITER //
CREATE PROCEDURE sp_armar_paquete (
    IN p_nombre VARCHAR(75),
    IN p_cantidad int,
    IN p_id_compra int
)
BEGIN	
    declare v_id_compra int;
    
	declare exit HANDLER for NOT FOUND
	BEGIN	
	ROLLBACK;
	  SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'No se encontró la compra indicada';
	END;

    SELECT id_compra INTO v_id_compra FROM compra
		WHERE id_compra = p_id_compra;

    START TRANSACTION;
    
    INSERT into paquete (nombre,cantidad,id_compra) 
		values (p_nombre,p_cantidad, v_id_compra);
    
    COMMIT;
END //
DELIMITER;
-- -------------------- verificacion de los datos -------------------- 
				CALL sp_armar_paquete('Paquete_001', 2, 1);
				SELECT * FROM paquete WHERE nombre = 'Paquete_001';


-- ------------------------------ -- ------------------------------ -- ------------------------------ 
-- ------------------------------ REGISTRO DE ENVIOS ------------------------------
-- sp_asignar_envio (p_id_paquete, p_id_transportista, p_id_vehiculo)
-- Asigna transportista y vehículo disponibles a un envío y registra en historial_envio.
DELIMITER //
CREATE PROCEDURE sp_registrar_envio (
    IN p_transportista VARCHAR(75),
    IN p_matricula VARCHAR(75),
    IN p_paquete VARCHAR(75),
    OUT fecha_entrega DATETIME
)
BEGIN	
	DECLARE v_id_transportista INT;
	DECLARE v_id_vehiculo INT;
	DECLARE v_id_paquete INT;
	DECLARE v_id_usuario INT;
	DECLARE v_fecha_asignacion DATETIME;
	DECLARE v_id_envio INT;
	DECLARE v_id_estado INT;

	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
		SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'Error durante el registro. Revise los datos y vuelva a intentar.';
	END;

	sTART tRANSACTION;

	-- Validaciones con SELECT INTO (evita nulos silenciosos)
	SELECT id_transportista INTO v_id_transportista
	FROM transportista
	WHERE nombre = p_transportista AND disponible = TRUE
	LIMIT 1;

	SELECT id_vehiculo INTO v_id_vehiculo
	FROM vehiculo
	WHERE matricula = p_matricula AND disponible = TRUE
	LIMIT 1;

	SELECT id_paquete iNTO v_id_paquete
	FROM paquete
	WHERE nombre = p_paquete
	LIMIT 1;

	SELECT c.id_usuario INTO v_id_usuario
	FROM paquete p  
	JOIN compra c ON p.id_compra = c.id_compra
	WHERE p.nombre = p_paquete
	LIMIT 1;

	SET fecha_entrega = NOW() + iNTERVAL 2 DAY;
	SET v_fecha_asignacion = NOW();

	SELECT id_estado INTO v_id_estado
	FROM estado_envio
	WHERE estado = "Preparando"
	LIMIT 1;

	-- Insertar envío
	INSERT INTO envio (id_paquete, id_usuario, fecha_entrega)
	VALUES (v_id_paquete, v_id_usuario, fecha_entrega);

	sET v_id_envio = LAST_INSERT_ID();

	-- Relacionar transportista
	INSERT INTO transportista_has_envio (id_transportista, id_envio, fecha_asignacion)
	VALUES (v_id_transportista, v_id_envio, v_fecha_asignacion);

	-- Marcar recursos como no disponibles
	UPDATE transportista SET disponible = FALSE WHERE id_transportista = v_id_transportista;
	UPDATE vehiculo SET disponible = FALSE WHERE id_vehiculo = v_id_vehiculo;

	-- Historial de envío
	INSERT INTO historial_envio (id_estado, id_envio, id_vehiculo, fecha_cambio)
	VALUES (v_id_estado, v_id_envio, v_id_vehiculo, v_fecha_asignacion);

	COMMIT;
END //
DELIMITER ;
-- -------------------- verificacion de los datos -------------------- 
-- Transportista y vehículo disponibles
CALL sp_registrar_envio("Juan", "2002", "Paquete_001", @fecha);
SELECT @fecha;
-- Error: transportista ya usado
CALL sp_registrar_envio("Juan", "2002", "Paquete_002", @fecha);
-- Error: matrícula inválida
CALL sp_registrar_envio("Juan", "9999", "Paquete_001", @fecha);




-- ------------------------------ -- ------------------------------ -- ------------------------------ 
-- ------------------------------ REGISTRO DE ENVIOS ------------------------------
DELIMITER //
CREATE PROCEDURE sp_avanzar_estado_envio (
    IN p_estado_actual VARCHAR(20)
)
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE v_id_envio INT;
    DECLARE v_id_estado_actual INT;
    DECLARE v_id_estado_nuevo INT;
    DECLARE v_estado_nuevo VARCHAR(20);
    DECLARE v_id_vehiculo INT;
    DECLARE v_fecha_nueva DATETIME;

    -- Cursor para buscar el estado 
    DECLARE cursor_paso_nivel CURSOR FOR
        SELECT he.id_envio FROM historial_envio he
        JOIN (select id_envio, MAX(fecha_cambio) as max_fecha from historial_envio group by id_envio) 
			ult ON he.id_envio = ult.id_envio AND he.fecha_cambio = ult.max_fecha
        JOIN estado_envio ee ON he.id_estado = ee.id_estado
        WHERE ee.estado = p_estado_actual;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    -- Asignamos el siguiente estado según el actual
    IF p_estado_actual = 'Preparando' THEN
        SET v_estado_nuevo = 'Viajando';
    ELSEIF p_estado_actual = 'Viajando' THEN
        SET v_estado_nuevo = 'Tránsito';
    ELSEIF p_estado_actual = 'Tránsito' THEN
        SET v_estado_nuevo = 'Entregado';
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Estado no válido para avanzar.';
    END IF;

    -- Buscar ID del estado nuevo
    sELECT id_estado INTO v_id_estado_nuevo FROM estado_envio
		WHERE estado = v_estado_nuevo LIMIT 1;

    OPEN cursor_paso_nivel;
		bucle: LOOP
			FETCH cur INTO v_id_envio;
			IF done THEN
				LEAVE bucle;
			END IF;

			-- Obtener vehículo del envío actual
			SELECT id_vehiculo, MAX(fecha_cambio) INTO v_id_vehiculo, v_fecha_nueva	FROM historial_envio
				WHERE id_envio = v_id_envio GROUP BY id_envio;

			-- Insertar nuevo estado
			INSERT INTO historial_envio (id_estado, id_envio, id_vehiculo, fecha_cambio)
				VALUES (v_id_estado_nuevo, v_id_envio, v_id_vehiculo, NOW());

		END LOOP;
    CLOSE cur;
END //

DELIMITER ;


-- -------------------- verificacion de los datos -------------------- 
-- Avanza todos los que están en "Preparando" → "Viajando"
CALL sp_avanzar_estado_envio('Preparando');

		SELECT 
			he.id_envio,
			ee.estado,
			he.fecha_cambio
		FROM historial_envio he
		JOIN estado_envio ee ON he.id_estado = ee.id_estado
		WHERE ee.estado = 'Viajando'
		ORDER BY he.fecha_cambio DESC;

-- Avanza todos los que están en "Viajando" → "Tránsito"
CALL sp_avanzar_estado_envio('Viajando');




-- ==================================================================================================================
-- 														VISTAS
-- ==================================================================================================================
-- ------------------------------ PRODUCTOS MAS VENDIDOS ------------------------------
CREATE VIEW vw_productos_mas_vendidos AS
	SELECT 
		p.id_producto,
		p.nombre,
		SUM(phc.cantidad) AS total_vendido,
		p.precio_unitario,
		p.estado
	FROm producto_has_compra phc
	JOIN producto p ON phc.id_producto = p.id_producto
	GROUP BY p.id_producto, p.nombre, p.precio_unitario, p.estado
	ORDER BY total_vendido DESC;
    
-- -------------------- verificacion de los datos -------------------- 
-- Top 5 productos más vendidos
SELECT * FROM vw_productos_mas_vendidos LIMIT 5;
-- Productos vendidos más de 100 veces
SELECT * FROM vw_productos_mas_vendidos WHERE total_vendido > 100;
-- Solo productos activos
SELECT * FROM vw_productos_mas_vendidos WHERE estado = TRUE;



-- ------------------------------ -- ------------------------------ -- ------------------------------ 
-- ------------------------------ CANTIDAD COMPRAS POR USUARIO  ------------------------------
CREATE VIEW vw_historico_compras_usuario AS
	SELECT u.nombre as nombre,
    u.apellido as apellido,
	count(id_compra) as compras
    from compra c
    join usuario u on c.id_usuario = u.id_usuario
	group by u.id_usuario, u.nombre, u.apellido
	ORDER BY compras DESC;
    
-- -------------------- verificacion de los datos -------------------- 
-- Ver todos los usuarios y cuántas compras hicieron
SELECT * FROM vw_historico_compras_usuario;
-- Usuarios con más de 3 compras
SELECT * FROM vw_historico_compras_usuario WHERe compras > 3;




-- ------------------------------ -- ------------------------------ -- ------------------------------ 
-- ------------------------------ AVISO DE STOCK BAJO ------------------------------
CREATE OR REPLACE VIEW vw_stock_bajo AS
	SELECT nombre, cantidad, precio_unitario FROM producto
		WHERE cantidad < 10 ORDER BY cantidad ASC;
    
-- -------------------- verificacion de los datos -------------------- 
/*hACEMOS UPDATE DE UN PRODUCTO PARA VER QUE FUNCIONA LA VIEW.*/
update producto set cantidad = 9 where nombre = "Protector facial completo";
update producto set cantidad = 8 where nombre = "Chaleco antivibratorio";
select * from vw_stock_bajo;




-- ------------------------------ -- ------------------------------ -- ------------------------------ 
-- ------------------------------ ESTADO DE TODOS LOS PAQUETES  ------------------------------
CREATE VIEW vw_estado_actual_paquetes AS
	SELECT p.nombre AS paquete, u.nombre AS usuario,
		ee.estado AS estado_actual,
		he.fecha_cambio AS fecha_estado,
		t.nombre AS transportista
	FROM historial_envio he
	JOIN (
		select id_envio, MAX(fecha_cambio) AS max_fecha from historial_envio group by id_envio)
			ult ON he.id_envio = ult.id_envio AND he.fecha_cambio = ult.max_fecha
	JOIN estado_envio ee ON he.id_estado = ee.id_estado
	JOIN envio e ON he.id_envio = e.id_envio
	JOiN paquete p ON e.id_paquete = p.id_paquete
	JOIN usuario u ON e.id_usuario = u.id_usuario 
	JOIN transportista_has_envio the ON the.id_envio = e.id_envio
	JOIN transportista t ON t.id_transportista = the.id_transportista;

-- -------------------- verificacion de los datos -------------------- 
SELECT * FROM vw_estado_actual_paquetes;
