using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Data.SqlClient;
using System.Web.Configuration;
using System.Data;


namespace ECommerceBeeBox.Admin.Model
{
    public class DashboardCount
    {
        string connectionString = WebConfigurationManager.ConnectionStrings["connection"].ConnectionString.ToString();

        SqlConnection con;
        SqlCommand cmd;
        SqlDataReader reader;

        public int Count(string tableName)
        {
            con = new SqlConnection(connectionString);
            con.Open();

            int count = 0;

            cmd = new SqlCommand("sp_Dashboard", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.AddWithValue("@Action", tableName);

            reader = cmd.ExecuteReader();

            while (reader.Read())
            {
                if (reader[0] == DBNull.Value)
                {
                    count = 0;
                }
                else
                {
                    count = Convert.ToInt32(reader[0]);
                }
            }

            reader.Close();
            con.Close();
            return count;
        }

        
    }
}