use test


/*procedimiento que ingresa o modifica un cliente verifica si el correo que voy a ingresar ya esta en uso 
 si es asi no lo guarda hasta que se cambie el correo*/


delimiter $
create procedure sp_registrarCliente(in id int,
									 in nombre varchar(20),
                                     in ape_1 varchar(20),
                                     in ape_2 varchar(20),
                                     in correo varchar(30),
                                     in telf varchar(8),
                                     out msj varchar(100)
                                     )
 begin
	 if(not exists(select * from clientes where ID_CLIENTE=id))
	 then
		if(exists(select * from clientes where CORREO_CLIENTE=correo))
		then
           set msj='El correo esta en uso por favor seleccione otro correo';
           select msj;
        else
			insert into clientes(NOMBRE_CLIENTE,APELLIDO1_CLIENTE,APELLIDO2_CLIENTE,CORREO_CLIENTE,TELEFONO_CLEINTE)
			values(nombre,ape_1,ape_2,correo,telf);
             set msj='Se a registrado correctamente';
           select msj;
        end if;
	else
		update clientes
        set NOMBRE_CLIENTE=nombre,
			APELLIDO1_CLIENTE=ape_1,
            APELLIDO2_CLIENTE=ape_2,
            CORREO_CLIENTE=correo,
            TELEFONO_CLEINTE=telf
            where ID_CLIENTE=id;
             set msj='La informacion del usuario se actualizo correctamente';
           select msj;
	end if;

end$




drop procedure sp_registrarCliente;

call sp_registrarCliente(0,'mario','Mora','leiton','jcam@gmail.cg','88880000',@msj)

select * from clientes
