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


CALL SP_ListaProfesionalesSolicitados('san Jose','Escazu','JARDINERO')
