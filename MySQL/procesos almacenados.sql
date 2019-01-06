-- ============== primero por el atributo premiun y luego por la calificacion .
-- ============== Proceso almacenado para buscar profesionales según su ocupación y ubicación ================ 
-- ============== recibe como parámetros el nombre de la profesion,provincia y cantón y ordena la lista 
-- ============== primero por el atributo premiun y luego por la calificación .



DELIMITER $
CREATE PROCEDURE  SP_ListaProfesionalesSolicitados(in _provincia varchar(20), in _canton varchar(20),in _ocupacion varchar(20))
BEGIN
	SELECT 
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
						   inner join ubicaciones_profesionales on usuarios.ID_USUARIO=ubicaciones_profecionales.ID_USUARIO
                           inner join ubicaciones on ubicaciones.ID_UBICAION=ubicaciones_profesionales.ID_UBICAION
                       where usuarios.PERFIL_PROFESIONAL=1 and  ubicaciones.PROVINCIA=_provincia and ubicaciones.CANTON=_canton and ocupaciones.NOMBRE_OCUPACION=_ocupacion
					   order by usuarios.USUARIO_PREMIUM desc,usuarios.CALIFIC_SUMA desc;
END $


-- CALL SP_ListaProfesionalesSolicitados('San Jose','Escazu','JARDINERO')





-- Resive como parametro el id del usuario verifica si existe y elimina el registro del usuario 
-- verificando en cada tabla de la base de datos donde este el id del usuario que se va a eliminar


DELIMITER $
CREATE PROCEDURE SP_EliminarUsuario(in _id integer, out msj varchar(100))
BEGIN
    IF EXISTS(SELECT * FROM usuarios WHERE ID_USUARIO = _id)
	THEN
	BEGIN
		  -- 1 eliminar sitios web
		  IF EXISTS(SELECT * FROM websites WHERE ID_USUARIO = _id)
		  THEN
				DELETE FROM websites WHERE ID_USUARIO=_id;
				
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




-- select msj='';

-- call SP_EliminarUsuario(3,@msj)
