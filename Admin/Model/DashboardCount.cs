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
                count = Convert.ToInt32(reader[0]);
            }


            reader.Close();
            con.Close();
            return count;
        }

        public double SoldAmount(string tableName)
        {
            con = new SqlConnection(connectionString);
            con.Open();

            double count = 0;

            cmd = new SqlCommand("sp_Dashboard", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.AddWithValue("@Action", tableName);

            reader = cmd.ExecuteReader();

            while (reader.Read())
            {
                count = Convert.ToDouble(reader[0]);
            }


            reader.Close();
            con.Close();
            return count;
        }




    }
}