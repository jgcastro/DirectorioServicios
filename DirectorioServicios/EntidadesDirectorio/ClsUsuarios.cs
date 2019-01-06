using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EntidadesDirectorio
{
    public class ClsUsuarios
    {
        //ARGUMENTOS
        int vgn_ID_Usuario, vgn_Calif_Contador, vgn_Calif_Suma;
        string vgc_Nombre_Profesional, vgc_Apellido1_Profesional, vgc_Apellido2_Profesional, vgc_Telefono_Profesional, vgc_Descripcion;
        bool vgb_Usuario_Premium, vgb_Perfil_Profesional;

        //CONSTRUCTOR
        public ClsUsuarios()
        {
            vgb_Perfil_Profesional = true;
            vgb_Usuario_Premium = true;
            vgc_Apellido1_Profesional = string.Empty;
            vgc_Apellido2_Profesional = string.Empty;
            vgc_Descripcion = string.Empty;
            vgc_Nombre_Profesional = string.Empty;
            vgc_Telefono_Profesional = string.Empty;
            vgn_Calif_Contador = 0;
            vgn_Calif_Suma = 0;
            vgn_ID_Usuario = 0;
        }
        public ClsUsuarios(int vgn_ID_Usuario, int vgn_Calif_Contador, int vgn_Calif_Suma, string vgc_Nombre_Profesional, string vgc_Apellido1_Profesional, string vgc_Apellido2_Profesional, string vgc_Telefono_Profesional, string vgc_Descripcion, bool vgb_Usuario_Premium, bool vgb_Perfil_Profesional)
        {
            this.vgn_ID_Usuario = vgn_ID_Usuario;
            this.vgn_Calif_Contador = vgn_Calif_Contador;
            this.vgn_Calif_Suma = vgn_Calif_Suma;
            this.vgc_Nombre_Profesional = vgc_Nombre_Profesional;
            this.vgc_Apellido1_Profesional = vgc_Apellido1_Profesional;
            this.vgc_Apellido2_Profesional = vgc_Apellido2_Profesional;
            this.vgc_Telefono_Profesional = vgc_Telefono_Profesional;
            this.vgc_Descripcion = vgc_Descripcion;
            this.vgb_Usuario_Premium = vgb_Usuario_Premium;
            this.vgb_Perfil_Profesional = vgb_Perfil_Profesional;
        }

        //PROPIEDADES
        public int ID_Usuario { get => vgn_ID_Usuario; set => vgn_ID_Usuario = value; }
        public int Calif_Contador { get => vgn_Calif_Contador; set => vgn_Calif_Contador = value; }
        public int Calif_Suma { get => vgn_Calif_Suma; set => vgn_Calif_Suma = value; }
        public string Nombre_Profesional { get => vgc_Nombre_Profesional; set => vgc_Nombre_Profesional = value; }
        public string Apellido1_Profesional { get => vgc_Apellido1_Profesional; set => vgc_Apellido1_Profesional = value; }
        public string Apellido2_Profesional { get => vgc_Apellido2_Profesional; set => vgc_Apellido2_Profesional = value; }
        public string Telefono_Profesional { get => vgc_Telefono_Profesional; set => vgc_Telefono_Profesional = value; }
        public string Descripcion { get => vgc_Descripcion; set => vgc_Descripcion = value; }
        public bool Usuario_Premium { get => vgb_Usuario_Premium; set => vgb_Usuario_Premium = value; }
        public bool Perfil_Profesional { get => vgb_Perfil_Profesional; set => vgb_Perfil_Profesional = value; }
    }
}
