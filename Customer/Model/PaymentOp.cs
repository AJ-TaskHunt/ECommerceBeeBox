using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Data.SqlClient;
using System.Web.Configuration;
using System.Data;

namespace ECommerceBeeBox.Customer.Model
{
    public class PaymentOp
    {
        //string connectionString = WebConfigurationManager.ConnectionStrings["connection"].ConnectionString.ToString();
        static SqlCommand cmd;
        public static void UpdateQuantity(int productId, int qty, SqlTransaction transaction, SqlConnection sqlConnection)
        {
            int DBQuantity;

            cmd = new SqlCommand("select * from Product where ProductId=@ProductId", sqlConnection, transaction);

            cmd.Parameters.AddWithValue("@ProductId", productId);

            SqlDataReader drQty = cmd.ExecuteReader();

            while (drQty.Read())
            {
                DBQuantity = (int)drQty["Quantity"];

                if (DBQuantity > qty && DBQuantity > 2)
                {
                    DBQuantity = DBQuantity - qty;

                    cmd = new SqlCommand("update Product set Quantity=@Quantity where ProductId=@ProductId", sqlConnection, transaction);
                    cmd.Parameters.AddWithValue("@ProductId", productId);
                    cmd.Parameters.AddWithValue("@Quantity", DBQuantity);

                    cmd.ExecuteNonQuery();
                }
            }

            drQty.Close();

        }

        public static void RemoveProductFromCart(int productId, int sessionId, SqlTransaction transaction, SqlConnection sqlConnection)
        {
            cmd = new SqlCommand("sp_DeleteCartItem", sqlConnection, transaction);

            cmd.Parameters.AddWithValue("@ProductId", productId);
            cmd.Parameters.AddWithValue("@CustomerId", sessionId);

            cmd.ExecuteNonQuery();

        }
    }
}