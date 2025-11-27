-- =======================================================
-- TABLA: producto
-- =======================================================

INSERT INTO producto (nombre, cantidad, precio_unitario, estado) VALUES
('Casco de seguridad industrial',                   120, 4500.00, true),
('Chaleco reflectante alta visibilidad',              150, 3200.00, true),
('Arnés de seguridad para trabajo en altura',          80, 8300.00, true),
('Guantes anti-corte para construcción',              200, 1500.00, true),
('Botas de seguridad con puntera de acero',           100, 9500.00, true),
('Gafas de seguridad anti-impacto',                  180, 2800.00, true),
('Protector facial completo',                         60, 6700.00, true),
('Protección auditiva (orejeras)',                    250, 1200.00, true),
('Mascarilla de protección respiratoria',            300,  800.00, true),
('Cinturón de seguridad para andamios',               90,  5200.00, true),
('Reflector luminoso adhesivo',                      400,   300.00, true),
('Rodilleras de protección para construcción',        100, 3500.00, true),
('Guantes térmicos de protección',                    150, 2200.00, true),
('Gorro de protección para soldadura',                130, 2600.00, true),
('Faja ergonómica para manejo de cargas',            80,  4100.00, true),
('Manta ignífuga para seguridad en incendios',         70,  5000.00, true),
('Zapatos de seguridad impermeables',               90,  8700.00, true),
('Chaleco antivibratorio',                           75,  5400.00, true),
('Casco con sistema de ventilación',                110, 4900.00, true),
('Guantes dieléctricos para trabajos eléctricos',    120, 4700.00, true);

-- =======================================================
-- TABLA: vehiculo
-- =======================================================
INSERT INTO vehiculo (modelo, matricula, disponible) VALUES
('Scania R500',         2001, true),
('Volvo FH16',          2002, true),
('Mercedes-Benz Actros',2003, true),
('Iveco Stralis',       2004, true),
('MAN TGX',             2005, true),
('DAF XF',              2006, true),
('Renault Magnum',      2007, true),
('Kenworth T600',       2008, true),
('Freightliner Cascadia',2009, true),
('Mack Anthem',         2010, true),
('Volvo FM',            2011, true),
('Mercedes Arocs',      2012, true),
('Scania P340',         2013, true),
('Iveco Eurocargo',     2014, true),
('MAN TGS',             2015, true),
('DAF LF',              2016, true),
('Renault Trucks D',    2017, true),
('Tata Prima',          2018, true),
('Mack Granite',        2019, true),
('Freightliner Columbia',2020, true);

-- =======================================================
-- TABLA: transportista
-- =======================================================
INSERT INTO transportista (nombre, apellido, disponible) VALUES
('Juan',      'García',      true),
('María',     'López',       true),
('Carlos',    'Martínez',    true),
('Andrés',    'Pérez',       true),
('Diego',     'Rodríguez',   true),
('Luisa',     'Sánchez',     true),
('Federico',  'Ramírez',     true),
('Verónica',  'Fernández',   true),
('Ricardo',   'Torres',      true),
('Sofía',     'Gutiérrez',   true),
('Esteban',   'Castro',      true),
('Florencia', 'Romero',      true),
('Martín',    'Vargas',      true),
('Natalia',   'Herrera',     true),
('Gustavo',   'González',    true),
('Julieta',   'Domínguez',   true),
('Leonardo',  'Molina',      true),
('Carolina',  'Díaz',        true),
('Ricardo',   'Figueroa',    true),
('Claudia',   'Morales',     true);

-- =======================================================
-- TABLA: direccion
-- =======================================================
INSERT INTO direccion (ciudad, pais, barrio, calle, numeracion, otras) VALUES
('Buenos Aires',         'Argentina', 'Palermo',          'Av. Corrientes',      '1234', 'Depto. 2B'),
('Córdoba',              'Argentina', 'Cerro de las Rosas','Ruta Provincial 7',  '567',  NULL),
('Rosario',              'Argentina', 'Echesortu',         'Calle San Martín',    '890', 'Entre A y B'),
('Mendoza',              'Argentina', 'Centro',            'Av. Independencia',   '45',  'Local 12'),
('La Plata',             'Argentina', 'Tolosa',            'Calle 11',            '101', 'Piso 3'),
('Mar del Plata',        'Argentina', 'Centro',            'Av. Colón',           '202', 'Frente a la plaza'),
('San Miguel de Tucumán', 'Argentina', 'Centro',            'Calle 9 de Julio',    '303', 'Edificio Azul'),
('Salta',                'Argentina', 'Balcarce',          'Av. 9 de Julio',      '404', NULL),
('Santa Fe',             'Argentina', 'Centro',            'Calle San Martín',    '505', 'Local 8'),
('Corrientes',           'Argentina', 'Centro',            'Rambla Uruguay',      '606', NULL),
('Resistencia',          'Argentina', 'Bermejo',           'Calle 25',            '707', NULL),
('Neuquén',              'Argentina', 'Centro',            'Av. Centenario',      '808', 'Apto 4'),
('Formosa',              'Argentina', 'Centro',            'Calle 10',            '909', NULL),
('Posadas',              'Argentina', 'San José',          'Av. San Martín',      '110', 'Entre Siempre Viva'),
('San Juan',             'Argentina', 'Centro',            'Calle Libertad',      '111', NULL),
('Paraná',               'Argentina', 'Santa Catalina',    'Av. Rivadavia',       '112', NULL),
('Santiago del Estero',  'Argentina', 'La Banda',          'Calle 8',             '113', NULL),
('La Rioja',             'Argentina', 'Centro',            'Av. Ocampo',          '114', NULL),
('San Luis',             'Argentina', 'Nueva',             'Calle Libertad',      '115', 'Casa 3'),
('Catamarca',            'Argentina', 'Centro',            'Av. 9 de Julio',      '116', NULL);

-- =======================================================
-- TABLA: usuario
-- =======================================================
INSERT INTO usuario (nombre, apellido, DNI, telefono, correo_electronico, id_direccion) VALUES
('Alejandro',  'González',   30123456, 1156789012, 'alejandro@mail.com',   1),
('Brenda',     'Martínez',   30234567, 1167890123, 'brenda@mail.com',      2),
('Federico',   'Pérez',      30345678, 1178901234, 'federico@mail.com',    3),
('Gabriela',   'Sánchez',    30456789, 1189012345, 'gabriela@mail.com',    4),
('Héctor',     'Rodríguez',  30567890, 1190123456, 'hector@mail.com',      5),
('Isabel',     'López',      30678901, 1123456789, 'isabel@mail.com',      6),
('Joaquín',    'Ramírez',    30789012, 1134567890, 'joaquin@mail.com',     7),
('Karina',     'Torres',     30890123, 1145678901, 'karina@mail.com',      8),
('Leonardo',   'Díaz',       30901234, 1156789023, 'leonardo@mail.com',    9),
('Mariana',    'Castro',     31012345, 1167890234, 'mariana@mail.com',    10),
('Nicolás',    'Gómez',      31123456, 1178902345, 'nicolas@mail.com',    11),
('Olga',       'Morales',    31234567, 1189013456, 'olga@mail.com',       12),
('Pablo',      'Herrera',    31345678, 1190124567, 'pablo@mail.com',      13),
('Quintina',   'Fuentes',    31456789, 1123455678, 'quintina@mail.com',   14),
('Raúl',       'Vargas',     31567890, 1134566789, 'raul@mail.com',       15),
('Silvia',     'Coria',      31678901, 1145677890, 'silvia@mail.com',     16),
('Tomás',      'Rojas',      31789012, 1156788901, 'tomas@mail.com',      17),
('Ursula',     'Navarro',    31890123, 1167899012, 'ursula@mail.com',     18),
('Víctor',     'Acosta',     31901234, 1178900123, 'victor@mail.com',     19),
('Ximena',     'Lemus',      32012345, 1189011234, 'ximena@mail.com',     20);

-- =======================================================
-- TABLA: estado_envio
-- =======================================================
-- Se insertan 20 registros alternando los 5 estados definidos
INSERT INTO estado_envio (estado) VALUES
('Preparando'),
('Viajando'),
('Tránsito'),
('Entregado'),
('Devuelto')/*,
('Preparando'),
('Viajando'),
('Tránsito'),
('Entregado'),
('Devuelto'),
('Preparando'),
('Viajando'),
('Tránsito'),
('Entregado'),
('Devuelto'),
('Preparando'),
('Viajando'),
('Tránsito'),
('Entregado'),
('Devuelto')*/;

-- =======================================================
-- TABLA: compra
-- =======================================================
INSERT INTO compra (id_usuario, precio_total, dia_compra) VALUES
(1, 13500.00, '2025-06-01 09:00:00'),  -- Compra 1
(2, 5600.00,  '2025-06-02 10:30:00'),  -- Compra 2
(3, 9100.00,  '2025-06-03 11:15:00'),  -- Compra 3
(4, 14700.00, '2025-06-04 12:00:00'),  -- Compra 4
(5, 7100.00,  '2025-06-05 13:45:00'),  -- Compra 5
(6, 13700.00, '2025-06-06 14:30:00'),  -- Compra 6
(7, 6600.00,  '2025-06-07 15:00:00'),  -- Compra 7
(8, 9900.00,  '2025-06-08 16:20:00'),  -- Compra 8
(9, 9100.00,  '2025-06-09 17:10:00'),  -- Compra 9
(10,14100.00, '2025-06-10 18:00:00'),  -- Compra 10
(11,9800.00,  '2025-06-11 09:30:00'),  -- Compra 11
(12,7700.00,  '2025-06-12 10:15:00'),  -- Compra 12
(13,16600.00, '2025-06-13 11:45:00'),  -- Compra 13
(14,12500.00, '2025-06-14 12:30:00'),  -- Compra 14
(15,10400.00, '2025-06-15 13:15:00'),  -- Compra 15
(16,14100.00, '2025-06-16 14:00:00'),  -- Compra 16
(17,2400.00,  '2025-06-17 15:30:00'),  -- Compra 17
(18,10400.00, '2025-06-18 16:10:00'),  -- Compra 18
(19,7000.00,  '2025-06-19 17:45:00'),  -- Compra 19
(20,13200.00, '2025-06-20 18:30:00');  -- Compra 20

-- =======================================================
-- TABLA: paquete
-- =======================================================
-- Para simplificar, asignamos 2 paquetes a algunas compras y 1 a otras
INSERT INTO paquete (nombre, cantidad, id_compra) VALUES 
('Paquete A1', 1, 1), 
('Paquete A2', 1, 1),
 ('Paquete B', 1, 2), 
 ('Paquete C', 1, 3),
 ('Paquete D', 1, 4),
 ('Paquete E', 1, 5), 
 ('Paquete F', 1, 6),
 ('Paquete G', 1, 7),
 ('Paquete H', 1, 8), 
 ('Paquete I', 1, 9),
 ('Paquete J', 1, 10), 
 ('Paquete K', 1, 11),
 ('Paquete L', 1, 12),
 ('Paquete M', 1, 13),
 ('Paquete N', 1, 14),
 ('Paquete O', 1, 15), 
 ('Paquete P', 1, 16), 
 ('Paquete Q', 1, 17), 
 ('Paquete R', 1, 18), 
 ('Paquete S', 1, 19), 
 ('Paquete T', 1, 20),
 ('Paquete U', 1, 2),  -- Otra opción para Compra 2 
 ('Paquete V', 1, 3),   -- Otra para Compra 3 
 ('Paquete W', 1, 4),   -- Otra para Compra 4
 ('Paquete X', 1, 5),   -- Otra para Compra 5 
 ('Paquete Y', 1, 6),   -- Otra para Compra 6 
 ('Paquete Z', 1, 7),   -- Otra para Compra 7 
 ('Paquete AA', 1, 8),  -- Otra para Compra 8 
 ('Paquete AB', 1, 9),  -- Otra para Compra 9 
 ('Paquete AC', 1, 10); -- Otra para Compra 10



-- =======================================================
-- TABLA: producto_has_compra
-- =======================================================
INSERT INTO producto_has_compra (id_compra, id_producto, cantidad) VALUES
-- Compra 1:
(1, 1, 2),
(1, 4, 3),
-- Compra 2:
(2, 2, 1),
(2, 8, 2),
-- Compra 3:
(3, 3, 1),
(3, 9, 1),
-- Compra 4:
(4, 5, 1),
(4, 10, 1),
-- Compra 5:
(5, 6, 2),
(5, 11, 5),
-- Compra 6:
(6, 7, 1),
(6, 12, 2),
-- Compra 7:
(7, 13, 3),
-- Compra 8:
(8, 14, 2),
(8, 20, 1),
-- Compra 9:
(9, 15, 1),
(9, 16, 1),
-- Compra 10:
(10, 17, 1),
(10, 18, 1),
-- Compra 11:
(11, 19, 2),
-- Compra 12:
(12, 1, 1),
(12, 2, 1),
-- Compra 13:
(13, 3, 2),
-- Compra 14:
(14, 4, 2),
(14, 5, 1),
-- Compra 15:
(15, 6, 1),
(15, 7, 1),
(15, 11, 3),
-- Compra 16:
(16, 8, 1),
(16, 12, 1),
(16, 20, 2),
-- Compra 17:
(17, 9, 3),
-- Compra 18:
(18, 10, 2),
-- Compra 19:
(19, 13, 2),
(19, 14, 1),
-- Compra 20:
(20, 15, 2),
(20, 16, 1);

-- =======================================================
-- TABLA: envio
-- =======================================================
-- Se asigna cada paquete a un usuario (el mismo que realizó la compra) con fechas consistentes
INSERT INTO envio (id_paquete, id_usuario, fecha_entrega) VALUES
(1, 1, '2025-06-03 10:00:00'),
(2, 1, '2025-06-03 11:00:00'),
(3, 2, '2025-06-04 09:30:00'),
(4, 3, '2025-06-05 10:15:00'),
(5, 4, '2025-06-06 11:00:00'),
(6, 5, '2025-06-07 12:00:00'),
(7, 6, '2025-06-08 11:30:00'),
(8, 7, '2025-06-09 10:45:00'),
(9, 8, '2025-06-10 09:20:00'),
(10, 9, '2025-06-11 10:00:00'),
(11, 10, '2025-06-12 11:15:00'),
(12, 11, '2025-06-13 10:30:00'),
(13, 12, '2025-06-14 09:45:00'),
(14, 13, '2025-06-15 10:30:00'),
(15, 14, '2025-06-16 11:00:00'),
(16, 15, '2025-06-17 10:15:00'),
(17, 16, '2025-06-18 09:50:00'),
(18, 17, '2025-06-19 10:20:00'),
(19, 18, '2025-06-20 11:00:00'),
(20, 19, '2025-06-21 10:05:00'),
(21, 20, '2025-06-22 09:40:00'),
(22, 1, '2025-06-23 10:15:00'),
(23, 2, '2025-06-24 10:45:00'),
(24, 3, '2025-06-25 09:55:00'),
(25, 4, '2025-06-26 10:30:00'),
(26, 5, '2025-06-27 11:10:00'),
(27, 6, '2025-06-28 10:00:00'),
(28, 7, '2025-06-29 09:30:00'),
(29, 8, '2025-06-30 10:00:00'),
(30, 9, '2025-07-01 09:50:00');

-- =======================================================
-- TABLA: transportista_has_envio
-- =======================================================
-- Se asigna cada envío a un transportista con una fecha de asignación previa a la entrega
INSERT INTO transportista_has_envio (id_transportista, id_envio, fecha_asignacion) VALUES
(1, 1, '2025-06-02 08:30:00'),
(2, 2, '2025-06-02 09:00:00'),
(3, 3, '2025-06-03 08:45:00'),
(4, 4, '2025-06-04 08:30:00'),
(5, 5, '2025-06-05 09:15:00'),
(6, 6, '2025-06-06 10:00:00'),
(7, 7, '2025-06-07 08:00:00'),
(8, 8, '2025-06-08 08:30:00'),
(9, 9, '2025-06-09 08:45:00'),
(10, 10, '2025-06-10 09:00:00'),
(1, 11, '2025-06-11 08:30:00'),
(2, 12, '2025-06-12 09:00:00'),
(3, 13, '2025-06-13 08:45:00'),
(4, 14, '2025-06-14 08:30:00'),
(5, 15, '2025-06-15 09:15:00'),
(6, 16, '2025-06-16 10:00:00'),
(7, 17, '2025-06-17 08:00:00'),
(8, 18, '2025-06-18 08:30:00'),
(9, 19, '2025-06-19 08:45:00'),
(10, 20, '2025-06-20 09:00:00'),
(1, 21, '2025-06-21 08:30:00'),
(2, 22, '2025-06-22 09:00:00'),
(3, 23, '2025-06-23 08:45:00'),
(4, 24, '2025-06-24 08:30:00'),
(5, 25, '2025-06-25 09:15:00'),
(6, 26, '2025-06-26 10:00:00'),
(7, 27, '2025-06-27 08:00:00'),
(8, 28, '2025-06-28 08:30:00'),
(9, 29, '2025-06-29 08:45:00'),
(10, 30, '2025-06-30 09:00:00');

-- =======================================================
-- TABLA: historial_envio
-- =======================================================
-- Se registra un cambio de estado para cada envío (dos registros por envío, por ejemplo)
INSERT INTO historial_envio (id_estado, id_envio, id_vehiculo, fecha_cambio) VALUES
(1, 1,  1, '2025-06-03 09:30:00'),
(2, 1,  1, '2025-06-03 09:45:00'),
(3, 2,  2, '2025-06-03 10:00:00'),
(4, 3,  3, '2025-06-04 09:15:00'),
(5, 4,  4, '2025-06-05 09:30:00'),
(1, 5,  5, '2025-06-06 10:00:00'),
(2, 6,  6, '2025-06-07 10:15:00'),
(3, 7,  7, '2025-06-08 10:30:00'),
(4, 8,  8, '2025-06-09 10:45:00'),
(5, 9,  9, '2025-06-10 11:00:00'),
(1, 10, 10, '2025-06-11 09:30:00'),
(2, 11, 1,  '2025-06-12 09:45:00'),
(3, 12, 2,  '2025-06-13 10:00:00'),
(4, 13, 3,  '2025-06-14 10:15:00'),
(5, 14, 4,  '2025-06-15 10:30:00'),
(1, 15, 5,  '2025-06-16 09:30:00'),
(2, 16, 6,  '2025-06-17 09:45:00'),
(3, 17, 7,  '2025-06-18 10:00:00'),
(4, 18, 8,  '2025-06-19 10:15:00'),
(5, 19, 9,  '2025-06-20 10:30:00'),
(1, 20, 10, '2025-06-21 09:30:00');

-- =======================================================
-- TABLA: historial_envio
-- =======================================================
-- Se crea un registro falso de productos actualizados
INSERT INTO actualizacion_stock_audit (
    id_producto, empleado, stock_anterior, stock_nuevo, fecha_modificacion
) VALUES
(1, 'juan@empresa.com', 120, 115, '2025-07-20 08:00:00'),
(2, 'carla@empresa.com', 150, 155, '2025-07-20 08:15:00'),
(3, 'sofia@empresa.com', 80, 75, '2025-07-20 08:30:00'),
(4, 'nico@empresa.com', 200, 190, '2025-07-20 09:00:00'),
(5, 'mariana@empresa.com', 100, 105, '2025-07-20 09:30:00'),
(6, 'juan@empresa.com', 180, 182, '2025-07-21 08:45:00'),
(7, 'carla@empresa.com', 60, 65, '2025-07-21 09:10:00'),
(8, 'sofia@empresa.com', 250, 245, '2025-07-21 10:00:00'),
(9, 'nico@empresa.com', 300, 310, '2025-07-21 10:30:00'),
(10, 'mariana@empresa.com', 90, 85, '2025-07-21 11:00:00'),
(11, 'juan@empresa.com', 400, 395, '2025-07-22 08:10:00'),
(12, 'carla@empresa.com', 100, 98, '2025-07-22 08:40:00'),
(13, 'sofia@empresa.com', 150, 160, '2025-07-22 09:15:00'),
(14, 'nico@empresa.com', 130, 128, '2025-07-22 09:50:00'),
(15, 'mariana@empresa.com', 80, 85, '2025-07-22 10:20:00'),
(16, 'juan@empresa.com', 70, 73, '2025-07-22 10:55:00'),
(17, 'carla@empresa.com', 90, 92, '2025-07-22 11:30:00'),
(18, 'sofia@empresa.com', 75, 70, '2025-07-22 12:00:00'),
(19, 'nico@empresa.com', 110, 112, '2025-07-22 12:30:00'),
(20, 'mariana@empresa.com', 120, 117, '2025-07-22 13:00:00');