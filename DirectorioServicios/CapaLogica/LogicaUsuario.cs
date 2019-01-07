using AccesoDatos;
using EntidadesDirectorio;
using System;
using System.Collections.Generic;

namespace CapaLogica
{
    public class LogicaUsuario
    {
        

        public List<ClsUsuarios> listaUsuarios(string condition)
        {
            AccesoDatosUsuario accesoDatosUsuario = new AccesoDatosUsuario();
            List<ClsUsuarios> lista = null;
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
