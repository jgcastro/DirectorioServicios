using Configuracion;
using EntidadesDirectorio;
using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;

namespace AccesoDatos
{
    public class AccesoDatosUsuario
    {

        MySqlCommand command = new MySqlCommand();
        MySqlDataReader reader = null;
        List<ClsUsuarios> vgo_listaUsuarios = new List<ClsUsuarios>();

        public List<ClsUsuarios> listaUsuarios(string condition)
        {

            MySqlConnection conexion = ClsConfiguracion.getConnectionString();

            try
            {
                command.Connection = conexion;
                command.CommandType = System.Data.CommandType.Text;
                command.CommandText = "SELECT * FROM USUARIOS";

                conexion.Open();

                reader = command.ExecuteReader();

                if (reader.HasRows)
                {

                    while (reader.Read())
                    {

                        vgo_listaUsuarios.Add(new ClsUsuarios(reader.GetInt32(0), reader.GetString(1), reader.GetString(2), reader.GetString(3), reader.GetString(4), reader.GetString(5), reader.GetString(6), reader.GetBoolean(7), reader.GetInt32(8), reader.GetInt32(9), reader.GetBoolean(10)));


                    }

                    reader.Close();

                }

                conexion.Close();
            }
            catch (MySqlException ex)
            {

                Console.WriteLine("error, " + ex.Message.ToString());
            }

            command.Dispose();
            conexion.Dispose();

            return vgo_listaUsuarios;


        }

    }
}
