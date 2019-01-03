/*CALL REGISTRAR_Y_ACTUALIZARINFO_USUARIOS(-1,'YO','VARGAS','FERNANDEZ','NINGUNO3','70302288','NADA',
                                                        0,
                                                        1,
                                                        1,
                                                        1, 
                                                        'NO_DETALLE', 
                                                        'NO_WEB', 
                                                        'NO_WEB');*/ /* LLAMADO DEL PROCEDIMIENTO*/




DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `REGISTRAR_Y_ACTUALIZARINFO_USUARIOS`(IN _ID_USUARIOS INT,
													  IN _NOMBRE VARCHAR(20),
                                                      IN _APELLIDO1 VARCHAR(20),
                                                      IN _APELLIDO2 VARCHAR(20),
                                                      IN _CORREO VARCHAR(30),
                                                      IN _TELEFONO VARCHAR(8),
                                                      IN _DESCRIPCION varchar(500),
                                                      IN _USUARIO_PREMIUM BIT,
                                                      IN _ES_PROFECIONAL BIT,
                                                      IN _ID_OCUPACION INT,
                                                      IN _ID_UBICACION INT,
                                                      IN _DETALLE_UBICACION VARCHAR(100),
                                                      IN _URL_SITIO VARCHAR(100),
                                                      IN _NOMBRE_SITIO VARCHAR(100))
BEGIN
DECLARE ID INT unsigned;
	IF _ID_USUARIOS IN(SELECT ID_USUARIO FROM USUARIOS) THEN
		CASE _ES_PROFECIONAL
		WHEN 1 THEN 
        
				UPDATE USUARIOS
				SET NOMBRE_PROFECIONAL=_NOMBRE,
					APELLIDO1_PROFECIONAL=_APELLIDO1,
					APELLIDO2_PROFECIONAL=_APELLIDO2,
					CORREO_PROFECIONAL=_CORREO,
					TELEFONO_PROFECIONAL=_TELEFONO,
					DESCRIPCION=_DESCRIPCION,
					USUARIO_PREMIUM=_USUARIO_PREMIUM
				WHERE ID_USUARIO=_ID_USUARIOS;
				
				update UBICACIONES_PROFECIONALES
				SET ID_UBICACION=_ID_UBICACION,
					DETALLES=_DETALLE_UBICACION
				WHERE ID_USUARIO=_ID_USUARIOS;
				
				UPDATE WEBSITES
				SET URL_SITIO=_URL_SITIO,
					NOMBRE_SITIO=NOMBRE_SITIO
				WHERE ID_USUARIO=_ID_USUARIOS;

		WHEN 0 THEN
        
			UPDATE USUARIOS
				SET NOMBRE_PROFECIONAL=_NOMBRE,
					APELLIDO1_PROFECIONAL=_APELLIDO1,
					APELLIDO2_PROFECIONAL=_APELLIDO2
				WHERE ID_USUARIO=_ID_USUARIOS;
                
		END CASE;
	ELSE 
		CASE _ES_PROFECIONAL
		WHEN 1 THEN 
        
				insert INTO USUARIOS(NOMBRE_PROFECIONAL,APELLIDO1_PROFECIONAL,APELLIDO2_PROFECIONAL,CORREO_PROFECIONAL,TELEFONO_PROFECIONAL,DESCRIPCION,USUARIO_PREMIUM,PERFIL_PROFESIONAL)
				VALUES(_NOMBRE,_APELLIDO1,_APELLIDO2,_CORREO,_TELEFONO,_DESCRIPCION,_USUARIO_PREMIUM,_ES_PROFECIONAL);
                SET ID=last_insert_id();
                
                insert INTO UBICACIONES_PROFECIONALES(ID_USUARIO,ID_UBICACION,DETALLES)
                VALUES(ID,_ID_UBICACION,_DETALLE_UBICACION);
                
                INSERT INTO OCUPACIONES_PROFECIONALES(ID_USUARIO,ID_OCUPACION)
                VALUES(ID,_ID_OCUPACION);
                
                INSERT INTO WEBSITES(ID_USUARIO,URL_SITIO,NOMBRE_SITIO)
                VALUES(ID,_URL_SITIO,NOMBRE_SITIO);
                
		WHEN 0 THEN
        
			insert INTO USUARIOS(NOMBRE_PROFECIONAL,APELLIDO1_PROFECIONAL,APELLIDO2_PROFECIONAL,CORREO_PROFECIONAL,TELEFONO_PROFECIONAL,DESCRIPCION,PERFIL_PROFESIONAL)
				VALUES(_NOMBRE,_APELLIDO1,_APELLIDO2,_CORREO,_TELEFONO,_DESCRIPCION,_ES_PROFECIONAL);
                
		END CASE;
	END IF;
END$$
DELIMITER ;