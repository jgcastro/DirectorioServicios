using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Configuration;
using MySql.Data.MySqlClient;

namespace Configuracion
{
    public class ClsConfiguracion
    {
        public static MySqlConnection getConnectionString()
        {
            MySqlConnection conexion = new MySqlConnection("server=localhost;uid=root;pwd=juanca;database=pagina_web;");
            return conexion;
        }
    }
}
