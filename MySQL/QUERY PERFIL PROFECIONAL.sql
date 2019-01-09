USE pagina_web;

-- procedimiento que recibe como para metro el id del profesional y retorna 
-- la lista de ocupaciones registradas por el usuario
DELIMITER $
	CREATE PROCEDURE SP_LISTA_OCUPACIONES_PROFESIONAL(IN _id INT)
    BEGIN
		select ocupaciones.ID_OCUPACION, concat(ocupaciones.NOMBRE_OCUPACION,' ',ocupaciones.ESPACIALIDAD_OCUPACION) as PROFECION from ocupaciones inner join
					 ocupaciones_profesionales on ocupaciones.ID_OCUPACION=ocupaciones_profesionales.ID_OCUPACION
                     where ocupaciones_profesionales.ID_USUARIO= _id;

    END
$


-- procedimiento que recibe como para metro el id del profesional y retorna 
-- la lista de ubicaciones registradas por el usuario
DELIMITER $
	CREATE PROCEDURE SP_LISTA_UBICACIONES_PROFESIONAL(IN _id INT)
    BEGIN
		select ubicaciones.* from ubicaciones inner join ubicaciones_profesionales
			   on ubicaciones.ID_UBICACION = ubicaciones_profesionales.ID_UBICACION
               where ubicaciones_profesionales.ID_USUARIO=_id;
    END
$




       select COD_SITIO,URL_SITIO,NOMBRE_SITIO from website where ID_USUARIO=3  ;   
       
       
       
       
       
        select concat(NOMBRE_PROFESIONAL,' ',APELLIDO1_PROFESIONAL,' ',APELLIDO2_PROFESIONAL) as NOMBRE,
					  CORREO_PROFESIONAL,
                      TELEFONO_PROFESIONAL from usuarios where ID_USUARIO=3   
        
        
        
        
                     
         
                     
                     
                     
                     
			
             
             
             
	
	





 -- INSERT INTO ocupaciones_profesionales(ID_USUARIO,ID_OCUPACION) VALUES(4,5);



-- SELECT * FROM ocupaciones_profesionales
-- 3 ID USUARIO

-- ID OCUPACION 1 Mecanico Agricola YA ESTA

-- ID OCUPACION 2 Mecanico Automotris
-- ID OCUPACION 7 Maestro de obras 
-- ID OCUPACION 4 Electricista 
-- ID OCUPACION 5 Plomero


