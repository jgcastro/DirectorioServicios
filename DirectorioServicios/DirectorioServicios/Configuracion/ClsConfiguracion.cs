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
        public static string getConnectionString()
        {
            string conexion = "server=localhost;uid=root;pwd=1234;database=pagina_web;";
            return conexion;
        }
    }
}
