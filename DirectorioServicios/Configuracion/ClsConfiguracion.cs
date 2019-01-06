using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Configuration;

namespace Configuracion
{
    public class ClsConfiguracion
    {
        public string getConnectionString
        {
            get
            {
                //se obtiene la cadena de conexion.
                return ConfigurationManager.AppSettings["ConnectionString"];
            }
        }
    }
}
