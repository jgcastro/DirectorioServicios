using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EntidadesDirectorio
{
    public class ClsUbicacionesProfesionales
    {
        int vgn_ID_Usuario, vgn_ID_Ubicacion;
        string vgc_Detalles;

        public ClsUbicacionesProfesionales()
        {
            vgc_Detalles = string.Empty;
            vgn_ID_Ubicacion = 0;
            vgn_ID_Usuario = 0;
        }

        public ClsUbicacionesProfesionales(int pvn_ID_Usuario, int pvn_ID_Ubicacion, string pvc_Detalles)
        {
            vgc_Detalles = pvc_Detalles;
            vgn_ID_Ubicacion = pvn_ID_Ubicacion;
            vgn_ID_Usuario = pvn_ID_Usuario;
        }

        public int ID_Usuario { get => vgn_ID_Usuario; set => vgn_ID_Usuario = value; }
        public int ID_Ubicacion1 { get => vgn_ID_Ubicacion; set => vgn_ID_Ubicacion = value; }
        public string Detalles { get => vgc_Detalles; set => vgc_Detalles = value; }
    }
}
