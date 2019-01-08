using AccesoDatos;
using EntidadesDirectorio;
using System;
using System.Collections.Generic;
using System.Data;

namespace CapaLogica
{
    public class LogicaUsuario
    {
        

        public DataTable listaUsuarios(string condition)
        {
            AccesoDatosUsuario accesoDatosUsuario = new AccesoDatosUsuario();
            DataTable lista = null;
            try
            {
                lista = accesoDatosUsuario.listaUsuarios(condition);
            }
            catch (Exception)
            {

                throw;
            }

            return lista;


        }

    }
}
