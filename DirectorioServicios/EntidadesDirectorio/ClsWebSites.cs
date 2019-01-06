using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EntidadesDirectorio
{
    public class ClsWebSites
    {
        int vgn_Cod_Sitio, vgn_ID_Usuario;
        string vgc_URL_Sitio, vgc_Nombre_Sitio;

        public ClsWebSites()
        {
            vgc_Nombre_Sitio = string.Empty;
            vgc_URL_Sitio = string.Empty;
            vgn_Cod_Sitio = 0;
            vgn_ID_Usuario = 0;
        }

        public ClsWebSites(int vgn_Cod_Sitio, int vgn_ID_Usuario, string vgc_URL_Sitio, string vgc_Nombre_Sitio)
        {
            this.vgn_Cod_Sitio = vgn_Cod_Sitio;
            this.vgn_ID_Usuario = vgn_ID_Usuario;
            this.vgc_URL_Sitio = vgc_URL_Sitio;
            this.vgc_Nombre_Sitio = vgc_Nombre_Sitio;
        }

        public int Cod_Sitio { get => vgn_Cod_Sitio; set => vgn_Cod_Sitio = value; }
        public int ID_Usuario { get => vgn_ID_Usuario; set => vgn_ID_Usuario = value; }
        public string URL_Sitio { get => vgc_URL_Sitio; set => vgc_URL_Sitio = value; }
        public string Nombre_Sitio { get => vgc_Nombre_Sitio; set => vgc_Nombre_Sitio = value; }
    }
}
