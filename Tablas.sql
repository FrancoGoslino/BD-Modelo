create database if not exists final_paqueteria_goslino;
CREATE USER 'admin'@'localhost' IDENTIFIED BY 'a123';
GRANT ALL PRIVILEGES ON final_paqueteria_goslino.* TO 'admin'@'localhost';
FLUSH PRIVILEGES;

USE final_paqueteria_goslino;

DROP TABLE IF EXISTS historial_envio;
DROP TABLE IF EXISTS transportista_has_envio;
DROP TABLE IF EXISTS envio;
DROP TABLE IF EXISTS paquete;
DROP TABLE IF EXISTS producto_has_compra;
DROP TABLE IF EXISTS compra;
DROP TABLE IF EXISTS usuario;
DROP TABLE IF EXISTS direccion;
DROP TABLE IF EXISTS producto;
DROP TABLE IF EXISTS vehiculo;
DROP TABLE IF EXISTS transportista;
DROP TABLE IF EXISTS estado_envio;

CREATE table producto(
  id_producto int auto_increment primary key,
  nombre varchar(75) NOT NULL UNIQUE,
  cantidad int unsigned NOT NULL check (cantidad >= 0),
  precio_unitario decimal(20,2) NOT NULL check (precio_unitario > 0),
  estado boolean default true NOT NULL
);

CREATE TABLE actualizacion_stock_audit(
	id_movimiento int auto_increment primary key,
    id_producto int NOT NULL,
    empleado varchar(75) NOT NULL,
    stock_anterior int NOT NULL,
    stock_nuevo int NOT NULL,
    fecha_modificacion datetime,
    constraint fk_act_stock_aud foreign key(id_producto) references producto(id_producto)
);

CREATE table vehiculo(
  id_vehiculo int auto_increment primary key NOT NULL,
  modelo varchar(75),
  matricula integer unsigned UNIQUE NOT NULL,
  disponible boolean DEFAULT (TRUE) NOT NULL
  );
  
CREATE table transportista(
  id_transportista int auto_increment primary key,
  nombre varchar(75) NOT NULL,
  apellido varchar(75) NOT NULL,
  disponible boolean default(true) NOT NULL
  );
  
CREATE table direccion(
  id_direccion int auto_increment primary key,
  ciudad varchar(75) NOT NULL,
  pais varchar(75) default ("Argentina") NOT NULL,
  barrio varchar(75) NOT NULL,
  calle varchar(75) NOT NULL,
  numeracion varchar(75), -- NO SIEMPRE siempre son numeraciones. (Ej: Km42; 401-A; 276 bis)
  otras varchar(75) DEFAULT NULL
  );
  
CREATE table usuario(
  id_usuario int auto_increment primary key,
  nombre varchar(75) NOT NULL,
  apellido varchar(75) NOT NULL,
  DNI integer unsigned UNIQUE,
  telefono integer unsigned NOT NULL,
  correo_electronico varchar(75) UNIQUE NOT NULL,
  id_direccion int NOT NULL,
  constraint fk_u_direccion foreign key(id_direccion) references direccion(id_direccion)
  );


CREATE table estado_envio (
  id_estado int auto_increment primary key NOT NULL,
  estado enum("Preparando","Viajando","Tránsito","Entregado", "Devuelto") DEFAULT ("Preparando") NOT NULL
  );
 
CREATE Table compra(
  id_compra int auto_increment primary key,
  id_usuario int NOT NULL,
  precio_total float unsigned NOT NULL,
  dia_compra datetime NOT NULL,
  constraint fk_c_usuario foreign key(id_usuario) references usuario(id_usuario)
);
 
CREATE table paquete(
  id_paquete int auto_increment primary key,
  nombre varchar(75) unique NOT NULL,
  cantidad int NOT NULL check (cantidad > 0),
  id_compra int NOT NULL,
  constraint fk_p_compra foreign key(id_compra) references compra(id_compra)
);

CREATE table producto_has_compra(
id_compra int NOT NULL,
id_producto int NOT NULL,
cantidad int NOT NULL check(cantidad > 0),
primary key(id_compra, id_producto),
constraint fk_phc_compra foreign key(id_compra) references compra(id_compra),
constraint fk_phc_producto foreign key(id_producto) references producto(id_producto)
);

CREATE table envio(
  id_envio int auto_increment primary key,
  id_paquete int NOT NULL, 
  id_usuario int NOT NULL,
  fecha_entrega datetime,
  constraint fk_e_paquete foreign key(id_paquete) references paquete(id_paquete),
  constraint fk_e_usuario foreign key(id_usuario) references usuario(id_usuario)
  );

CREATE table transportista_has_envio(
  id_transportista int NOT NULL,
  id_envio int NOT NULL,
  fecha_asignacion datetime NOT NULL,
  primary key (id_transportista, id_envio),
  constraint fk_the_envio foreign key(id_envio) references envio(id_envio),
  constraint fk_the_transportista foreign key(id_transportista) references transportista(id_transportista)
);

CREATE TABLE historial_envio (
  id_historial INT AUTO_INCREMENT PRIMARY KEY,
  id_estado INT NOT NULL,
  id_envio INT NOT NULL,
  id_vehiculo INT NOT NULL,
  fecha_cambio DATETIME NOT NULL,
  CONSTRAINT fk_he_estado FOREIGN KEY (id_estado) REFERENCES estado_envio(id_estado),
  CONSTRAINT fk_he_envio FOREIGN KEY (id_envio) REFERENCES envio(id_envio),
  CONSTRAINT fk_he_vehiculo FOREIGN KEY (id_vehiculo) REFERENCES vehiculo(id_vehiculo)
);