 
 -- ================================= REGISTRAR O MODIFICAR USUARIO ================================= --
 
/*
CALL REGISTRAR_O_ACTUALIZARINFO_USUARIOS(-1,'YO','VARGAS','FERNANDEZ','NINGUNO3','70302288','NADA',
                                                        0,
                                                        1,
                                                        1,
                                                        1, 
                                                        'NO_DETALLE', 
                                                        'NO_WEB', 
                                                        'NO_WEB');
*/ 

/* LLAMADO DEL PROCEDIMIENTO*/
DELIMITER $
DROP PROCEDURE IF EXISTS `PAGINA_WEB`.`SP_REGISTRAR_O_ACTUALIZAR_USUARIO` $ -- facilita actualizar el procedimiento
CREATE PROCEDURE `PAGINA_WEB`.`SP_REGISTRAR_O_ACTUALIZAR_USUARIO`(IN _ID_USUARIOS INT,
													  IN _NOMBRE VARCHAR(20),
                                                      IN _APELLIDO1 VARCHAR(20),
                                                      IN _APELLIDO2 VARCHAR(20),
                                                      IN _CORREO VARCHAR(30),
                                                      IN _TELEFONO VARCHAR(8),
                                                      IN _DESCRIPCION varchar(500),
                                                      IN _USUARIO_PREMIUM BIT,
                                                      IN _ES_PROFESIONAL BIT,
                                                      IN _ID_OCUPACION INT,
                                                      IN _ID_UBICACION INT,
                                                      IN _DETALLE_UBICACION VARCHAR(100),
                                                      IN _URL_SITIO VARCHAR(100),
                                                      IN _NOMBRE_SITIO VARCHAR(100))
BEGIN
DECLARE ID INT unsigned;
	IF _ID_USUARIOS IN(SELECT ID_USUARIO FROM USUARIOS) THEN
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
				
				update UBICACIONES_PROFESIONALES
				SET ID_UBICACION=_ID_UBICACION,
					DETALLES=_DETALLE_UBICACION
				WHERE ID_USUARIO=_ID_USUARIOS;
				
				UPDATE WEBSITE
				SET URL_SITIO=_URL_SITIO,
					NOMBRE_SITIO=NOMBRE_SITIO
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
                SET ID=last_insert_id();
                
                insert INTO UBICACIONES_PROFESIONALES(ID_USUARIO,ID_UBICACION,DETALLES)
                VALUES(ID,_ID_UBICACION,_DETALLE_UBICACION);
                
                INSERT INTO OCUPACIONES_PROFESIONALES(ID_USUARIO,ID_OCUPACION)
                VALUES(ID,_ID_OCUPACION);
                
                INSERT INTO WEBSITE(ID_USUARIO,URL_SITIO,NOMBRE_SITIO)
                VALUES(ID,_URL_SITIO,NOMBRE_SITIO);
                
		WHEN 0 THEN
        
			insert INTO USUARIOS(NOMBRE_PROFESIONAL,APELLIDO1_PROFESIONAL,APELLIDO2_PROFESIONAL,CORREO_PROFESIONAL,TELEFONO_PROFESIONAL,DESCRIPCION,PERFIL_PROFESIONAL)
				VALUES(_NOMBRE,_APELLIDO1,_APELLIDO2,_CORREO,_TELEFONO,_DESCRIPCION,_ES_PROFESIONAL);
                
		END CASE;
	END IF;
END $
DELIMITER ;

-- ============== ELIMINAR_USUARIO ================ --
DELIMITER $
-- Resive como parametro el id del usuario verifica si existe y elimina el registro del usuario 
-- verificando en cada tabla de la base de datos donde este el id del usuario que se va a eliminar

-- select msj='';
-- call SP_EliminarUsuario(3,@msj)

DROP PROCEDURE IF EXISTS `PAGINA_WEB`.`SP_EliminarUsuario` $ -- facilita actualizar el procedimiento
CREATE PROCEDURE `PAGINA_WEB`.`SP_EliminarUsuario`(in _id integer, out msj varchar(100))
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


