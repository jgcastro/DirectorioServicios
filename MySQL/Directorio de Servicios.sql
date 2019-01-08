-- =========== Directorio de Servicios: "IMPLEMENTACION DE LA BASE DE DATOS =========== --
-- ================================= Utilizando MySQL ================================= --

CREATE DATABASE PAGINA_WEB;

USE PAGINA_WEB;


-- ===========================TABLA "PROFESIONALES Y CLIENTES"=========================== --
/*
Almacena los profesionales
*/
CREATE TABLE USUARIOS (
	ID_USUARIO INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT, -- SOLO POSITIVOS
	NOMBRE_PROFESIONAL VARCHAR(20) NOT NULL,
	APELLIDO1_PROFESIONAL VARCHAR(20) NOT NULL,
	APELLIDO2_PROFESIONAL VARCHAR(20),
	CORREO_PROFESIONAL VARCHAR(30) , 
	TELEFONO_PROFESIONAL VARCHAR(8) UNIQUE NOT NULL, -- EL TELEFONO NO SE REPITE
	DESCRIPCION VARCHAR(200),
	USUARIO_PREMIUM BIT DEFAULT 0 NOT NULL, -- USUARIO DE PAGA
	CALIFIC_CONTADOR INT UNSIGNED,		-- CUENTA LAS CALIFICACIONES
	CALIFIC_SUMA INT UNSIGNED,			-- SUMA DE LAS CALIFICACIONES
	PERFIL_PROFESIONAL BIT DEFAULT 0 NOT NULL -- DEFINE SI ES CLIENTE=0 PROFESIONAL=1
);

-- ===========================TABLA "CALIFICACIONES"=========================== --
/*
Almacena las calificaciones que los clientes le dieron a los profesionales
tambien contiene los comentarios y la fecha en que se hicieron
los clientes solo pueden calificar a los profesionales una vez
*/
CREATE TABLE CALIFICACIONES (
    ID_USUARIO INTEGER UNSIGNED,
	CALIFICACION DECIMAL(3,2),
    COMENTARIO VARCHAR(200),
    FECHA TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, -- ALMACENA LA FECHA EN QUE SE CREO
    PRIMARY KEY (ID_USUARIO)
);
ALTER TABLE CALIFICACIONES ADD FOREIGN KEY (ID_USUARIO) REFERENCES USUARIOS(ID_USUARIO);

-- ===========================TABLA "OCUPACIONES"=========================== --
/*
almacena las diferentes ocupaciones
evita datos repetidos
*/
CREATE TABLE OCUPACIONES (
	ID_OCUPACION INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	NOMBRE_OCUPACION VARCHAR(20) NOT NULL,
	ESPACIALIDAD_OCUPACION VARCHAR(20)
);

-- ===========================TABLA "OCUPACIONES_PROFESIONALES"=========================== --
/*
asigna una o multiples ocupacione a los profesionales
*/
CREATE TABLE OCUPACIONES_PROFESIONALES (
	ID_USUARIO INTEGER UNSIGNED,
	ID_OCUPACION INTEGER UNSIGNED,
    
    -- Un profesional no puede tener la misma ocupacion dos veces
    PRIMARY KEY(ID_USUARIO, ID_OCUPACION)
);
ALTER TABLE OCUPACIONES_PROFESIONALES ADD FOREIGN KEY (ID_USUARIO) REFERENCES USUARIOS(ID_USUARIO);
ALTER TABLE OCUPACIONES_PROFESIONALES ADD FOREIGN KEY (ID_OCUPACION) REFERENCES OCUPACIONES(ID_OCUPACION);

-- ===========================TABLA "WEBSITES"=========================== --
/*
almacena los sitios web suministrados por el profesional
*/

CREATE TABLE WEBSITES (

	COD_SITIO INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,-- LE AGREGO EL COD_SITIO COMO LLAVE PRIMARIA PARA QUE ME PERMITA EDITAR EL NOMBRE DEL SITIO Y LA URL
    ID_USUARIO INTEGER UNSIGNED,
	URL_SITIO VARCHAR(20),
    NOMBRE_SITIO VARCHAR(20)
);
ALTER TABLE WEBSITES ADD FOREIGN KEY (ID_USUARIO) REFERENCES USUARIOS(ID_USUARIO);

-- ===========================TABLA "UBICACIONES"=========================== --
/*
almacena las ubicaciones
es para mantener consistencia en los datos
hay que cargar todos los cantones
*/
CREATE TABLE UBICACIONES (
	ID_UBICACION INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	PROVINCIA ENUM('San José',
					'Alajuela',
					'Cartago',
					'Heredia',
					'Guanacaste',
					'Puntarenas',
					'Limón') NOT NULL,
    CANTON VARCHAR(20)
);

-- ===========================TABLA "OCUPACIONES_PROFESIONALES"=========================== --
/*
asigna una o multiples ubicaciones a los profesionales
*/
CREATE TABLE UBICACIONES_PROFESIONALES (
	ID_USUARIO INTEGER UNSIGNED,
	ID_UBICACION INTEGER UNSIGNED,
    DETALLES VARCHAR(100), -- opcional (direccion exacta)
    
    -- Un profesional no puede tener la misma ocupacion dos veces
    PRIMARY KEY(ID_USUARIO, ID_UBICACION)
);

ALTER TABLE UBICACIONES_PROFESIONALES ADD FOREIGN KEY (ID_USUARIO) REFERENCES USUARIOS(ID_USUARIO);
ALTER TABLE UBICACIONES_PROFESIONALES ADD FOREIGN KEY (ID_UBICACION) REFERENCES UBICACIONES(ID_UBICACION);


-- DROP DATABASE DIRECTORIO_SERVICIOS

