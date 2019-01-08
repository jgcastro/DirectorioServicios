using CapaLogica;
using EntidadesDirectorio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DirectorioServicios
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
            if (!IsPostBack)
            {               
                LogicaUsuario logica = new LogicaUsuario();

                try
                {
                    grd_usuarios.DataSource = logica.listaUsuarios(null);
                    grd_usuarios.DataBind();
                }
                catch (Exception)
                {

                    throw;
                }

            }
        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}