using Configuracion;
using EntidadesDirectorio;
using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Data;

namespace AccesoDatos
{
    public class AccesoDatosUsuario
    {
        //Este metodo retorna una lista de usuarios.
        public DataTable listaUsuarios(string condition)
        {
            //Se establese una variable para retornar una tabla.
            DataTable vlo_ListaUsuarios = new DataTable();

            //Se establese una variable de conexión instanciando la conexion de MySQL
            MySqlConnection conexion = new MySqlConnection();

            //Se establese la cadena de conexión obteniendola de la configuración.
            conexion.ConnectionString = ClsConfiguracion.getConnectionString();

            //Se establese una variable de comandos.
            MySqlCommand command;

            //Se establese una variable de tipo data adapter.
            MySqlDataAdapter vlo_DA;

            try
            {
                //Se abre la conexión.
                conexion.Open();

                //Se instancia el comando con la sentencia.
                command = new MySqlCommand("SELECT * FROM USUARIOS");

                //Se establese la conexión.
                command.Connection = conexion;
                //command.CommandType = System.Data.CommandType.Text;
                //command.CommandText = "SELECT * FROM USUARIOS";

                //Se instancia el data adpter con el comando.
                vlo_DA = new MySqlDataAdapter(command);

                //Se rellena la tabla 
                vlo_DA.Fill(vlo_ListaUsuarios);

                vlo_DA.Dispose();
                conexion.Close();
                command.Dispose();
                conexion.Dispose();
            }
            catch (MySqlException ex)
            {

                Console.WriteLine("error, " + ex.Message.ToString());
            }

            return vlo_ListaUsuarios;
        }

        public int InsertarUsuario(ClsUsuarios pvo_Usuario)
        {
            //Variables
            int vln_Correcta = 0;

            //Inicio

            return vln_Correcta;
        }

    }
}
