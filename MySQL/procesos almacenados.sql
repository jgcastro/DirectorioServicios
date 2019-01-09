-- ============== Proceso almacenado para buscar profesionales según su ocupación y ubicación ================ 
-- ============== recibe como parámetros el nombre de la profesion,provincia y cantón y ordena la lista 
-- ============== primero por el atributo premiun y luego por la calificación .

use pagina_web;

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
					   order by usuarios.USUARIO_PREMIUM desc,usuarios.CALIFIC_SUMA desc,usuarios.NOMBRE_PROFESIONAL;
END $


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
		  IF EXISTS(SELECT * FROM website WHERE ID_USUARIO = _id)
		  THEN
				DELETE FROM website WHERE ID_USUARIO=_id;
				
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



-- proceso almacenado para agregar paginas web 

DELIMITER $
CREATE PROCEDURE SP_AgregarSitiosWeb(in _cod_sitio int, in _id int ,in _url varchar(20),in _nombre varchar(20), out _msj varchar(100))
BEGIN 
	IF NOT EXISTS(SELECT * FROM websites WHERE COD_SITIO=_cod_sitio)
    THEN
    BEGIN
		INSERT INTO website(ID_USUARIO,URL_SITIO,NOMBRE_SITIO) VALUES(_id,_url,_nombre);
        SET _msj='El sitio web se agrego correctamente';
        
    END; 
    ELSE 
    BEGIN 
		UPDATE website
        SET URL_SITIO=_url,NOMBRE_SITIO=_nombre
        WHERE COD_SITIO =_cod_sitio;
        SET _msj='El sitio web se actualizo correctamente';
    END ;
    END IF;

END $


-- drop procedure SP_EliminarUsuario
--PROCEDIMIENTO PARA AGREGAR UNA OCUPACIÓN
use pagina_web;
DELIMITER $
CREATE PROCEDURE Sp_AgregarOcupacion(in _idOcupacion int,in _nombre varchar(20),in _especialidad varchar(20),out _msj varchar(100) )
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
																 

