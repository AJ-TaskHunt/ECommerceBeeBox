using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Data.SqlClient;
using System.Web.Configuration;
using System.Data;
using System.Web.Services;

namespace ECommerceBeeBox.Seller.Model
{
    public class CheckData
    {
        public bool checkUserName(string username)
        {
            bool name = false;

            string connectionString = WebConfigurationManager.ConnectionStrings["connection"].ConnectionString.ToString();

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                using (SqlCommand command = new SqlCommand("select * from Seller where Name=@name", connection))
                {
                    command.Parameters.AddWithValue("@name", username);

                    using (SqlDataReader dr = command.ExecuteReader())
                    {
                        if(dr.Read())
                        {
                            name = true;
                        }
                    }
                }
            }

            return name;
        }
    }
}