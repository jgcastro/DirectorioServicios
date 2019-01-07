
USE DIRECTORIO_SERVICIOS;
-- ============== Buscar profesionales según su ocupación y ubicación ================ --
DELIMITER $
-- ============== recibe como parámetros el nombre de la profesion,provincia y cantón y ordena la lista 
-- ============== primero por el atributo premiun y luego por la calificación .
DROP PROCEDURE IF EXISTS `DIRECTORIO_SERVICIOS`.`SP_ListaProfesionalesSolicitados` $ -- facilita actualizar el procedimiento
CREATE PROCEDURE `DIRECTORIO_SERVICIOS`.`SP_ListaProfesionalesSolicitados`(in _provincia varchar(20), 
																			in _canton varchar(20),
																			in _ocupacion varchar(20))
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

DELIMITER ;

-- ========== Agregar o Actualizar Pagina web ========== --
DELIMITER $
DROP PROCEDURE IF EXISTS `DIRECTORIO_SERVICIOS`.`SP_AgregarSitioWeb` $ -- facilita actualizar el procedimiento
CREATE PROCEDURE `DIRECTORIO_SERVICIOS`.`SP_AgregarSitioWeb`(in _cod_sitio int, in _id int ,in _url varchar(20),in _nombre varchar(20), out _msj varchar(100))
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

DELIMITER ;

-- ========== Eliminar Pagina web ========== --
DELIMITER $
DROP PROCEDURE IF EXISTS `DIRECTORIO_SERVICIOS`.`SP_EliminarSitiosWeb` $ -- facilita actualizar el procedimiento
CREATE PROCEDURE `DIRECTORIO_SERVICIOS`.`SP_EliminarSitiosWeb`(in _cod_sitio int, in _id int ,in _url varchar(20),in _nombre varchar(20), out _msj varchar(100))
BEGIN 
	IF EXISTS(SELECT * FROM websites WHERE COD_SITIO=_cod_sitio) THEN
		BEGIN
			DELETE FROM websites WHERE COD_SITIO=_cod_sitio;
			SET _msj='El sitio web se elimino correctamente';
		END; 
    ELSE 
		BEGIN 
			SET _msj='El sitio web no existe';
		END ;
    END IF;
END $
DELIMITER ;
