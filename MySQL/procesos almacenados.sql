-- ============== Proceso almacenado para buscar profesionales según su ocupación y ubicación ================ 
-- ============== recibe como parámetros el nombre de la profesion,provincia y cantón y ordena la lista 
-- ============== primero por el atributo premiun y luego por la calificación .

USE PAGINA_WEB;

DELIMITER $
CREATE PROCEDURE  SP_ListaProfesionalesSolicitados(in _provincia varchar(20), in _canton varchar(20),in _ocupacion varchar(20))
BEGIN
	SELECT 
		usuarios.ID_USUARIO,
		usuarios.NOMBRE_PROFESIONAL,
        usuarios.APELLIDO1_PROFESIONAL,
        usuarios.APELLIDO2_PROFESIONAL,
        usuarios.TELEFONO_PROFESIONAL,
        ocupaciones.NOMBRE_OCUPACION,
		ocupaciones.ESPACIALIDAD_OCUPACION,
        ubicaciones.PROVINCIA,
        ubicaciones.CANTON,
        usuarios.CALIFIC_SUMA
        
    FROM usuarios inner join ocupaciones_profesionales on usuarios.ID_USUARIO=ocupaciones_profesionales.ID_USUARIO
						   inner join ocupaciones on ocupaciones.ID_OCUPACION=ocupaciones_profesionales.ID_OCUPACION
						   inner join ubicaciones_profesionales on usuarios.ID_USUARIO=ubicaciones_profesionales.ID_USUARIO
                           inner join ubicaciones on ubicaciones.ID_UBICACION=ubicaciones_profesionales.ID_UBICACION
                       where usuarios.PERFIL_PROFESIONAL=1 and  ubicaciones.PROVINCIA=_provincia and ubicaciones.CANTON=_canton and ocupaciones.NOMBRE_OCUPACION=_ocupacion
					   order by usuarios.USUARIO_PREMIUM desc,usuarios.CALIFIC_SUMA desc;
END $
DELIMITER ;



-- CALL SP_ListaProfesionalesSolicitados('San Jose','Escazu','JARDINERO')

-- drop procedure SP_ListaProfesionalesSolicitados

-- Resive como parametro el id del usuario verifica si existe y elimina el registro del usuario 
-- verificando en cada tabla de la base de datos donde este el id del usuario que se va a eliminar
DELIMITER $
CREATE PROCEDURE SP_EliminarUsuario(in _id integer, out msj varchar(100))
BEGIN
    IF EXISTS(SELECT * FROM usuarios WHERE ID_USUARIO = _id)
	THEN
	BEGIN
		  -- 1 eliminar sitios web
		  IF EXISTS(SELECT * FROM WEBSITES WHERE ID_USUARIO = _id)
		  THEN
				DELETE FROM WEBSITES WHERE ID_USUARIO=_id;
				
            END IF;  
             -- 2 eliminar ubicaciones
            IF EXISTS(SELECT * FROM ubicaciones_profesionales WHERE ID_USUARIO = _id)
			THEN
				DELETE FROM ubicaciones_profesionales WHERE ID_USUARIO=_id;
				
            END IF;  
             -- 3 eliminar ocupaciones
			IF EXISTS(SELECT * FROM ocupaciones_profesionales WHERE ID_USUARIO = _id)
			THEN
				DELETE FROM ocupaciones_profesionales WHERE ID_USUARIO=_id;
				
            END IF;
			-- 4 eliminar calificaciones
			IF EXISTS(SELECT * FROM calificaciones WHERE ID_USUARIO = _id)
			THEN
				DELETE FROM calificaciones WHERE ID_USUARIO=_id;
		
            END IF;
			-- 5 eliminar usuario
			IF EXISTS(SELECT * FROM usuarios WHERE ID_USUARIO = _id)
			THEN
				DELETE FROM usuarios WHERE ID_USUARIO=_id;
		
            END IF;
		  SET msj='Su cuenta fue eliminada con exito';
	END;
	ELSE
		SET msj='no existe el usuario';
	END IF;
    
	SELECT msj;
END $
DELIMITER ;

-- select msj='';



-- proceso almacenado para agregar paginas web 

DELIMITER $
CREATE PROCEDURE SP_AgregarSitiosWeb(in _cod_sitio int, in _id int ,in _url varchar(20),in _nombre varchar(20), out _msj varchar(100))
BEGIN 
	IF NOT EXISTS(SELECT * FROM WEBSITES WHERE COD_SITIO=_cod_sitio)
    THEN
    BEGIN
		INSERT INTO WEBSITES(ID_USUARIO,URL_SITIO,NOMBRE_SITIO) VALUES(_id,_url,_nombre);
        SET _msj='El sitio web se agrego correctamente';
        
    END; 
    ELSE 
    BEGIN 
		UPDATE WEBSITES
        SET URL_SITIO=_url,NOMBRE_SITIO=_nombre
        WHERE COD_SITIO =_cod_sitio;
        SET _msj='El sitio web se actualizo correctamente';
    END ;
    END IF;

END $
DELIMITER ;

-- Eliminar Pagina web
DELIMITER $
CREATE PROCEDURE SP_EliminarSitiosWeb(in _cod_sitio int, out _msj varchar(100))
BEGIN 
	IF EXISTS(SELECT * FROM WEBSITES WHERE COD_SITIO=_cod_sitio) THEN
		BEGIN
			DELETE FROM WEBSITES WHERE COD_SITIO=_cod_sitio;
			SET _msj='El sitio web se elimino correctamente';
		END; 
    ELSE 
		BEGIN 
			SET _msj='El sitio web no existe';
		END ;
    END IF;
END $
DELIMITER ;

-- PROCEDIMIENTO PARA AGREGAR UNA OCUPACIÓN
DELIMITER $
CREATE PROCEDURE SP_AgregarOcupacion(in _idOcupacion int,in _nombre varchar(20),in _especialidad varchar(20),out _msj varchar(100))
BEGIN
	IF EXISTS(SELECT * FROM ocupaciones WHERE ID_OCUPACION = _idOcupacion)
    THEN
    BEGIN
		UPDATE ocupaciones
        SET NOMBRE_OCUPACION = _nombre,
			ESPACIALIDAD_OCUPACION = _especialidad
        WHERE ID_OCUPACION = _idOcupacion;
        SET _msj='La ocupación se agrego correctamente';
    END;
    ELSE
		BEGIN
			INSERT INTO ocupaciones (NOMBRE_OCUPACION,ESPACIALIDAD_OCUPACION)
            VALUES(_nombre,_especialidad);
        
	END;
    END IF;
    
END $																 
DELIMITER ;

-- ========== Agregar o Actualizar Ubicacion Profecional ========== --
DELIMITER $
CREATE PROCEDURE SP_AgregarUbicacionProfecional(in _ID_USUARIO int, 
												in _ID_UBICACION int,
												in _DETALLES varchar(100),
												out _msj varchar(100))
BEGIN 
	IF NOT EXISTS(SELECT * FROM UBICACIONES_PROFESIONALES WHERE ID_USUARIO=_ID_USUARIO AND ID_UBICACION=_ID_UBICACION)
    THEN
    BEGIN
		INSERT INTO UBICACIONES_PROFESIONALES(ID_USUARIO,ID_UBICACION,DETALLES) VALUES(_ID_USUARIO,_ID_UBICACION,_DETALLES);
        SET _msj='La ubicación se agrego correctamente';
        
    END; 
    ELSE 
    BEGIN 
		UPDATE UBICACIONES_PROFESIONALES 
        SET ID_UBICACION=_ID_UBICACION, DETALLES=_DETALLES
        WHERE ID_USUARIO=_ID_USUARIO AND ID_UBICACION=_ID_UBICACION;
        SET _msj='La ubicacíon se actualizo correctamente';
    END ;
    END IF;

END $

DELIMITER ;


-- =============== Eliminar Ubicacion Profecional ================= --
DELIMITER $
CREATE PROCEDURE SP_EliminarUbicacionProfecional(in _ID_USUARIO int, 
												in _ID_UBICACION int,
												out _msj varchar(100))
BEGIN 
	IF EXISTS(SELECT * FROM UBICACIONES_PROFESIONALES WHERE ID_USUARIO=_ID_USUARIO AND ID_UBICACION=_ID_UBICACION) THEN
		BEGIN
			DELETE FROM UBICACIONES_PROFESIONALES WHERE ID_USUARIO=_ID_USUARIO AND ID_UBICACION=_ID_UBICACION;
			SET _msj='El sitio web se elimino correctamente';
		END; 
    ELSE 
		BEGIN 
			SET _msj='El sitio web no existe';
		END ;
    END IF;
END $
DELIMITER ;

-- ===== REGISTRAR_Y_ACTUALIZAR_USUARIO ===== --

DELIMITER $
CREATE PROCEDURE `SP_REGISTRAR_Y_ACTUALIZAR_USUARIO`(IN _ID_USUARIO INT,
													 IN _NOMBRE VARCHAR(20),
                                                     IN _APELLIDO1 VARCHAR(20),
                                                     IN _APELLIDO2 VARCHAR(20),
                                                     IN _CORREO VARCHAR(30),
                                                     IN _TELEFONO VARCHAR(8),
                                                     IN _DESCRIPCION varchar(500),
                                                     IN _USUARIO_PREMIUM BIT,
                                                     IN _ES_PROFESIONAL BIT)
BEGIN
	IF _ID_USUARIO IN(SELECT ID_USUARIO FROM USUARIOS) THEN
		CASE _ES_PROFESIONAL
		WHEN 1 THEN 
        
				UPDATE USUARIOS
				SET NOMBRE_PROFESIONAL=_NOMBRE,
					APELLIDO1_PROFESIONAL=_APELLIDO1,
					APELLIDO2_PROFESIONAL=_APELLIDO2,
					CORREO_PROFESIONAL=_CORREO,
					TELEFONO_PROFESIONAL=_TELEFONO,
					DESCRIPCION=_DESCRIPCION,
					USUARIO_PREMIUM=_USUARIO_PREMIUM
				WHERE ID_USUARIO=_ID_USUARIOS;
		WHEN 0 THEN
        
			UPDATE USUARIOS
				SET NOMBRE_PROFESIONAL=_NOMBRE,
					APELLIDO1_PROFESIONAL=_APELLIDO1,
					APELLIDO2_PROFESIONAL=_APELLIDO2
				WHERE ID_USUARIO=_ID_USUARIOS;
                
		END CASE;
	ELSE 
		CASE _ES_PROFESIONAL
		WHEN 1 THEN 
        
				insert INTO USUARIOS(NOMBRE_PROFESIONAL,APELLIDO1_PROFESIONAL,APELLIDO2_PROFESIONAL,CORREO_PROFESIONAL,TELEFONO_PROFESIONAL,DESCRIPCION,USUARIO_PREMIUM,PERFIL_PROFESIONAL)
				VALUES(_NOMBRE,_APELLIDO1,_APELLIDO2,_CORREO,_TELEFONO,_DESCRIPCION,_USUARIO_PREMIUM,_ES_PROFESIONAL);
             		        SET _ID_USUARIO=last_insert_id();
		WHEN 0 THEN
        
			insert INTO USUARIOS(NOMBRE_PROFESIONAL,APELLIDO1_PROFESIONAL,APELLIDO2_PROFESIONAL,PERFIL_PROFESIONAL)
				VALUES(_NOMBRE,_APELLIDO1,_APELLIDO2,_ES_PROFESIONAL);
                
		END CASE;
	END IF;
END $
DELIMITER ;


DELIMITER $
CREATE PROCEDURE `SP_INSERTAR_OCUPACION_DE_USUARIO`(IN _ID_USUARIO INT,
									  IN _ID_OCUPACION int,
                                      IN _msg varchar(500))
BEGIN
	if _ID_OCUPACION IN(SELECT ID_OCUPACION FROM OCUPACIONES_PROFECIONALES WHERE ID_USUARIO=_ID_USUARIO) THEN
		SET _msg='La ocupación ya esta registrada con este usuario';
	else
		INSERT INTO OCUPACIONES_PROFECIONALES
       		 VALUES(_ID_USUARIO,_ID_OCUPACION);
    END IF;
END $
DELIMITER ;

DELIMITER $
CREATE PROCEDURE `SP_REMOVER_OCUPACION_DE_USUARIO`(IN _ID_USUARIO INT,
						IN _ID_OCUPACION int)
BEGIN
	DELETE FROM OCUPACIONES_PROFECIONALES WHERE ID_USUARIO=_ID_USUARIO AND ID_OCUPACION=_ID_OCUPACION;
END$$
DELIMITER ;

