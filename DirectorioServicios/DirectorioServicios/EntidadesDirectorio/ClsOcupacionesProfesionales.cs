using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EntidadesDirectorio
{
    public class ClsOcupacionesProfesionales
    {
        int vgn_ID_Usuario, vgn_ID_Ocupacion;

        public ClsOcupacionesProfesionales()
        {
            vgn_ID_Ocupacion = 0;
            vgn_ID_Usuario = 0;
        }

        public ClsOcupacionesProfesionales(int vgn_ID_Usuario, int vgn_ID_Ocupacion)
        {
            this.vgn_ID_Usuario = vgn_ID_Usuario;
            this.vgn_ID_Ocupacion = vgn_ID_Ocupacion;
        }

        public int ID_Usuario { get => vgn_ID_Usuario; set => vgn_ID_Usuario = value; }
        public int ID_Ocupacion { get => vgn_ID_Ocupacion; set => vgn_ID_Ocupacion = value; }
    }
}
