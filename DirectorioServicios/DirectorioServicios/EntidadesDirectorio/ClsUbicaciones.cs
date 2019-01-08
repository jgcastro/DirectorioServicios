using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EntidadesDirectorio
{
    public class ClsUbicaciones
    {
        int vgn_ID_Ubicacion;
        string vgc_Provincia, vgc_Canton;

        public ClsUbicaciones()
        {
            vgc_Canton = string.Empty;
            vgc_Provincia = string.Empty;
            vgn_ID_Ubicacion = 0;
        }

        public ClsUbicaciones(int vgn_ID_Ubicacion, string vgc_Provincia, string vgc_Canton)
        {
            this.vgn_ID_Ubicacion = vgn_ID_Ubicacion;
            this.vgc_Provincia = vgc_Provincia;
            this.vgc_Canton = vgc_Canton;
        }

        public int ID_Ubicacion { get => vgn_ID_Ubicacion; set => vgn_ID_Ubicacion = value; }
        public string Provincia { get => vgc_Provincia; set => vgc_Provincia = value; }
        public string Canton { get => vgc_Canton; set => vgc_Canton = value; }
    }
}
