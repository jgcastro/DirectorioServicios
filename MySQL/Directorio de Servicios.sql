-- =========== Directorio de Servicios: "IMPLEMENTACION DE LA BASE DE DATOS =========== --
-- ================================= Utilizando MySQL ================================= --

CREATE DATABASE PAGINA_WEB;

USE PAGINA_WEB;


-- ===========================TABLA "PROFESIONALES Y CLIENTES"=========================== --
/*
Almacena los profecionales
*/
CREATE TABLE USUARIOS (
	ID_USUARIO INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT, -- SOLO POSITIVOS
	NOMBRE_PROFECIONAL VARCHAR(20) NOT NULL,
	APELLIDO1_PROFECIONAL VARCHAR(20) NOT NULL,
	APELLIDO2_PROFECIONAL VARCHAR(20),
    CORREO_PROFECIONAL VARCHAR(30) UNIQUE NOT NULL, -- EL CORREO NO SE REPITE
    TELEFONO_PROFECIONAL VARCHAR(8),
    
    DESCRIPCION VARCHAR(200),
    CALIFIC_CONTADOR INT UNSIGNED,		-- CUENTA LAS CALIFICACIONES
    CALIFIC_SUMA INT UNSIGNED,			-- SUMA DE LAS CALIFICACIONES
	PERFIL_PROFESIONAL BIT DEFAULT 0 NOT NULL -- DEFINE SI ES CLIENTE=0 PROFESIONAL=1
);

-- ===========================TABLA "CALIFICACIONES"=========================== --
/*
Almacena las calificaciones que los clientes le dieron a los profecionales
tambien contiene los comentarios y la fecha en que se hicieron
los clientes solo pueden calificar a los profecionales una vez
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
	NOMBRE_OCUPACION VARCHAR(20),
	ESPACIALIDAD_OCUPACION VARCHAR(20)
);

-- ===========================TABLA "OCUPACIONES_PROFECIONALES"=========================== --
/*
asigna una o multiples ocupacione a los profecionales
*/
CREATE TABLE OCUPACIONES_PROFECIONALES (
	ID_USUARIO INTEGER UNSIGNED,
	ID_OCUPACION INTEGER UNSIGNED,
    
    -- Un profecional no puede tener la misma ocupacion dos veces
    PRIMARY KEY(ID_USUARIO, ID_OCUPACION)
);
ALTER TABLE OCUPACIONES_PROFECIONALES ADD FOREIGN KEY (ID_USUARIO) REFERENCES USUARIOS(ID_USUARIO);
ALTER TABLE OCUPACIONES_PROFECIONALES ADD FOREIGN KEY (ID_OCUPACION) REFERENCES OCUPACIONES(ID_OCUPACION);

-- ===========================TABLA "WEBSITES"=========================== --
/*
almacena los sitios web suministrados por el profecional
*/
CREATE TABLE WEBSITES (
    ID_USUARIO INTEGER UNSIGNED,
	URL_SITIO VARCHAR(20),
    NOMBRE_SITIO VARCHAR(20),
    PRIMARY KEY (ID_USUARIO, URL_SITIO)
);
ALTER TABLE WEBSITES ADD FOREIGN KEY (ID_USUARIO) REFERENCES USUARIOS(ID_USUARIO);

-- ===========================TABLA "UBICACIONES"=========================== --
/*
almacena las ubicaciones
es para mantener consistencia en los datos
hay que cargar todos los cantones
*/
CREATE TABLE UBICACIONES (
	ID_UBICAION INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	PROVINCIA ENUM('San José',
					'Alajuela',
					'Cartago',
					'Heredia',
                   			'Guanacaste',
					'Puntarenas',
					'Limón') NOT NULL,
    CANTON VARCHAR(20)
);

-- ===========================TABLA "OCUPACIONES_PROFECIONALES"=========================== --
/*
asigna una o multiples ubicaciones a los profecionales
*/
CREATE TABLE UBICACIONES_PROFECIONALES (
	ID_USUARIO INTEGER UNSIGNED,
	ID_UBICAION INTEGER UNSIGNED,
    DETALLES VARCHAR(100), -- opcional (direccion exacta)
    
    -- Un profecional no puede tener la misma ocupacion dos veces
    PRIMARY KEY(ID_USUARIO, ID_UBICAION)
);
ALTER TABLE UBICACIONES_PROFECIONALES ADD FOREIGN KEY (ID_USUARIO) REFERENCES USUARIOS(ID_USUARIO);
ALTER TABLE UBICACIONES_PROFECIONALES ADD FOREIGN KEY (ID_UBICAION) REFERENCES UBICACIONES(ID_UBICAION);
