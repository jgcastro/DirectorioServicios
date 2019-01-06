-- ============== Proceso almacenado para buscar profecionales segun su ocupación y ubicación ================ 
-- ============== resibe como parametros el nombre de la profecion,provincia y canton y ordena la lista 
-- ============== primero por el atributo premiun y luego por la calificacion .



DELIMITER $
CREATE PROCEDURE  SP_ListaProfesionalesSolicitados(in _provincia varchar(20), in _canton varchar(20),in _ocupacion varchar(20))
BEGIN
	SELECT 
		usuarios.NOMBRE_PROFECIONAL,
        usuarios.APELLIDO1_PROFECIONAL,
        usuarios.APELLIDO2_PROFECIONAL,
        usuarios.TELEFONO_PROFECIONAL,
        ocupaciones.NOMBRE_OCUPACION,
		ocupaciones.ESPACIALIDAD_OCUPACION,
        ubicaciones.PROVINCIA,
        ubicaciones.CANTON,
        usuarios.CALIFIC_SUMA
        
    FROM usuarios inner join ocupaciones_profecionales on usuarios.ID_USUARIO=ocupaciones_profecionales.ID_USUARIO
						   inner join ocupaciones on ocupaciones.ID_OCUPACION=ocupaciones_profecionales.ID_OCUPACION
						   inner join ubicaciones_profecionales on usuarios.ID_USUARIO=ubicaciones_profecionales.ID_USUARIO
                           inner join ubicaciones on ubicaciones.ID_UBICAION=ubicaciones_profecionales.ID_UBICAION
                       where usuarios.PERFIL_PROFESIONAL=1 and  ubicaciones.PROVINCIA=_provincia and ubicaciones.CANTON=_canton and ocupaciones.NOMBRE_OCUPACION=_ocupacion
					   order by usuarios.USUARIO_PREMIUM desc,usuarios.CALIFIC_SUMA desc;
END $


-- CALL SP_ListaProfesionalesSolicitados('san Jose','Escazu','JARDINERO')





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
            IF EXISTS(SELECT * FROM ubicaciones_profecionales WHERE ID_USUARIO = _id)
			THEN
				DELETE FROM ubicaciones_profecionales WHERE ID_USUARIO=_id;
				
            END IF;  
             -- 3 eliminar ocupaciones
			IF EXISTS(SELECT * FROM ocupaciones_profecionales WHERE ID_USUARIO = _id)
			THEN
				DELETE FROM ocupaciones_profecionales WHERE ID_USUARIO=_id;
				
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

-- proceso almacenado para agregar paginas web 

DELIMITER $
CREATE PROCEDURE SP_AgregarSitiosWeb(in _cod_sitio int, in _id int ,in _url varchar(20),in _nombre varchar(20), out _msj varchar(100))
BEGIN 
	IF NOT EXISTS(SELECT * FROM websites WHERE COD_SITIO=_cod_sitio)
    THEN
    BEGIN
		INSERT INTO websites(ID_USUARIO,URL_SITIO,NOMBRE_SITIO) VALUES(_id,_url,_nombre);
        SET _msj='El sitio web se agrego correctamente';
        
    END; 
    ELSE 
    BEGIN 
		UPDATE websites 
        SET URL_SITIO=_url,NOMBRE_SITIO=_nombre
        WHERE COD_SITIO =_cod_sitio;
        SET _msj='El sitio web se actualizo correctamente';
    END ;
    END IF;

END $
