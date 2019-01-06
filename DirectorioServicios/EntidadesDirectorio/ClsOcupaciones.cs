using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EntidadesDirectorio
{
    class ClsOcupaciones
    {
        int vgn_ID_Ocupacion;
        string vgc_Nombre_Ocupacion, vgc_Especialidad;

        public ClsOcupaciones()
        {
            vgc_Especialidad = string.Empty;
            vgc_Nombre_Ocupacion = string.Empty;
            vgn_ID_Ocupacion = 0;
        }

        public ClsOcupaciones(int vgn_ID_Ocupacion, string vgc_Nombre_Ocupacion, string vgc_Especialidad)
        {
            this.vgn_ID_Ocupacion = vgn_ID_Ocupacion;
            this.vgc_Nombre_Ocupacion = vgc_Nombre_Ocupacion;
            this.vgc_Especialidad = vgc_Especialidad;
        }

        public int ID_Ocupacion { get => vgn_ID_Ocupacion; set => vgn_ID_Ocupacion = value; }
        public string Nombre_Ocupacion { get => vgc_Nombre_Ocupacion; set => vgc_Nombre_Ocupacion = value; }
        public string Especialidad { get => vgc_Especialidad; set => vgc_Especialidad = value; }
    }
}
