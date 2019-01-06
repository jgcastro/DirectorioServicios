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
        public string getConnectionString()
        {
            string Cadena = string.Empty;

            Cadena = "Server=Localhost; Database=pagina_web; UID=root; PWD=1234; Port=3306";
            return Cadena;
        }
    }
}
