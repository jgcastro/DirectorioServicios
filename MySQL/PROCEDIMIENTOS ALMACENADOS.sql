
USE DIRECTORIO_SERVICIOS;
-- ============== Buscar profesionales según su ocupación y ubicación ================ --
DELIMITER $
-- ============== recibe como parámetros el nombre de la profesion,provincia y cantón y ordena la lista 
-- ============== primero por el atributo premiun y luego por la calificación .
DROP PROCEDURE IF EXISTS `PAGINA_WEB`.`SP_ListaProfesionalesSolicitados` $ -- facilita actualizar el procedimiento
CREATE PROCEDURE `PAGINA_WEB`.`SP_ListaProfesionalesSolicitados`(in _provincia varchar(20), 
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
		inner join ubicaciones_profesionales on usuarios.ID_USUARIO=ubicaciones_profesionales.ID_USUARIO
		inner join ubicaciones on ubicaciones.ID_UBICAION=ubicaciones_profesionales.ID_UBICAION
			where usuarios.PERFIL_PROFESIONAL=1 and  ubicaciones.PROVINCIA=_provincia and ubicaciones.CANTON=_canton and ocupaciones.NOMBRE_OCUPACION=_ocupacion
			order by usuarios.USUARIO_PREMIUM desc,usuarios.CALIFIC_SUMA desc;
END $

-- CALL SP_ListaProfesionalesSolicitados('San Jose','Escazú','JARDINERO')

DELIMITER ;

-- ========== Agregar o Actualizar Página web ========== --
DELIMITER $
DROP PROCEDURE IF EXISTS `PAGINA_WEB`.`SP_AgregarSitioWeb` $ -- facilita actualizar el procedimiento
CREATE PROCEDURE `PAGINA_WEB`.`SP_AgregarSitioWeb`(in _cod_sitio int, in _id int ,in _url varchar(20),in _nombre varchar(20), out _msj varchar(100))
BEGIN 
	IF NOT EXISTS(SELECT * FROM websites WHERE COD_SITIO=_cod_sitio)
    THEN
    BEGIN
		INSERT INTO websites(ID_USUARIO,URL_SITIO,NOMBRE_SITIO) VALUES(_id,_url,_nombre);
        SET _msj='El sitio web se agregó correctamente';
        
    END; 
    ELSE 
    BEGIN 
		UPDATE websites 
        SET URL_SITIO=_url,NOMBRE_SITIO=_nombre
        WHERE COD_SITIO =_cod_sitio;
        SET _msj='El sitio web se actualizó correctamente';
    END ;
    END IF;

END $

DELIMITER ;

-- ========== Eliminar Página web ========== --
DELIMITER $
DROP PROCEDURE IF EXISTS `PAGINA_WEB`.`SP_EliminarSitiosWeb` $ -- facilita actualizar el procedimiento
CREATE PROCEDURE `PAGINA_WEB`.`SP_EliminarSitiosWeb`(in _cod_sitio int, out _msj varchar(100))
BEGIN 
	IF EXISTS(SELECT * FROM websites WHERE COD_SITIO=_cod_sitio) THEN
		BEGIN
			DELETE FROM websites WHERE COD_SITIO=_cod_sitio;
			SET _msj='El sitio web se eliminó correctamente';
		END; 
    ELSE 
		BEGIN 
			SET _msj='El sitio web no existe';
		END ;
    END IF;
END $
DELIMITER ;


-- ========== Agregar o Actualizar Ubicación Profesional ========== --
DELIMITER $
DROP PROCEDURE IF EXISTS `PAGINA_WEB`.`SP_AgregarUbicacionProfesional` $ -- facilita actualizar el procedimiento
CREATE PROCEDURE `PAGINA_WEB`.`SP_AgregarUbicacionProfesional`(in _ID_USUARIO int, 
																  in _ID_UBICACION int,
                                                                  in _DETALLES varchar(100),
                                                                  out _msj varchar(100))
BEGIN 
	IF NOT EXISTS(SELECT * FROM UBICACIONES_PROFESIONALES WHERE ID_USUARIO=_ID_USUARIO AND ID_UBICACION=_ID_UBICACION)
    THEN
    BEGIN
		INSERT INTO UBICACIONES_PROFESIONALES(ID_USUARIO,ID_UBICACION,DETALLES) VALUES(_ID_USUARIO,_ID_UBICACION,_DETALLES);
        SET _msj='La ubicación se agregó correctamente';
        
    END; 
    ELSE 
    BEGIN 
		UPDATE UBICACIONES_PROFESIONALES 
        SET ID_UBICACION=_ID_UBICACION, DETALLES=_DETALLES
        WHERE ID_USUARIO=_ID_USUARIO AND ID_UBICACION=_ID_UBICACION;
        SET _msj='La ubicacíon se actualizó correctamente';
    END ;
    END IF;

END $

DELIMITER ;


-- =============== Eliminar Ubicación Profesional ================= --
DELIMITER $
DROP PROCEDURE IF EXISTS `PAGINA_WEB`.`SP_EliminarUbicacionProfesional` $ -- facilita actualizar el procedimiento
CREATE PROCEDURE `PAGINA_WEB`.`SP_EliminarUbicacionProfesional`(in _ID_USUARIO int, 
																		  in _ID_UBICACION int,
																		  out _msj varchar(100))
BEGIN 
	IF EXISTS(SELECT * FROM UBICACIONES_PROFESIONALES WHERE ID_USUARIO=_ID_USUARIO AND ID_UBICACION=_ID_UBICACION) THEN
		BEGIN
			DELETE FROM UBICACIONES_PROFESIONALES WHERE ID_USUARIO=_ID_USUARIO AND ID_UBICACION=_ID_UBICACION;
			SET _msj='El sitio web se eliminó correctamente';
		END; 
    ELSE 
		BEGIN 
			SET _msj='El sitio web no existe';
		END ;
    END IF;
END $
DELIMITER ;
