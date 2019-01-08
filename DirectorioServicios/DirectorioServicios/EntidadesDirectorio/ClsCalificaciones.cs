using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EntidadesDirectorio
{
    class ClsCalificaciones
    {
        int vgn_ID_Usuario;
        decimal vgn_Califiacion;
        DateTime vgd_Fecha;
        string vgc_Comentario;

        public ClsCalificaciones()
        {
            vgc_Comentario = string.Empty;
            vgd_Fecha = DateTime.Today;
            vgn_Califiacion = 0;
            vgn_ID_Usuario = 0;
        }

        public ClsCalificaciones(int vgn_ID_Usuario, decimal vgn_Califiacion, DateTime vgd_Fecha, string vgc_Comentario)
        {
            this.vgn_ID_Usuario = vgn_ID_Usuario;
            this.vgn_Califiacion = vgn_Califiacion;
            this.vgd_Fecha = vgd_Fecha;
            this.vgc_Comentario = vgc_Comentario;
        }

        public int ID_Usuario { get => vgn_ID_Usuario; set => vgn_ID_Usuario = value; }
        public decimal Califiacion { get => vgn_Califiacion; set => vgn_Califiacion = value; }
        public DateTime Fecha { get => vgd_Fecha; set => vgd_Fecha = value; }
        public string Comentario { get => vgc_Comentario; set => vgc_Comentario = value; }
    }
}
