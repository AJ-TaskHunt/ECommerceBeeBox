using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Data.SqlClient;
using System.Web.Configuration;
using System.Data;

using ECommerceBeeBox.Customer.Model;

namespace ECommerceBeeBox.Customer.Model
{
    public class PaymentOp
    {
        //string connectionString = WebConfigurationManager.ConnectionStrings["connection"].ConnectionString.ToString();
         SqlCommand command;
        public void UpdateQuantity(int productId, int qty, SqlConnection sqlConnection)
        {
            int DBQuantity;

            command = new SqlCommand("select * from Product where ProductId=@ProductId", sqlConnection);

            command.Parameters.AddWithValue("@ProductId", productId);

            SqlDataReader drQty = command.ExecuteReader();

            while (drQty.Read())
            {
                DBQuantity = (int)drQty["Quantity"];

                if (DBQuantity > qty && DBQuantity > 2)
                {
                    DBQuantity = DBQuantity - qty;

                    command = new SqlCommand("update Product set Quantity=@Quantity where ProductId=@ProductId", sqlConnection);
                    command.Parameters.AddWithValue("@ProductId", productId);
                    command.Parameters.AddWithValue("@Quantity", DBQuantity);

                    command.ExecuteNonQuery();
                }
                drQty.Close();
            }


        }

        public void RemoveProductFromCart(int productId, int sessionId, SqlConnection sqlConnection)
        {
            command = new SqlCommand("sp_DeleteCartItem", sqlConnection);

            command.Parameters.AddWithValue("@ProductId", productId);
            command.Parameters.AddWithValue("@CustomerId", sessionId);

            command.ExecuteNonQuery();

        }

        public void OrderData(int productId, int Quantity, int sessionId, int paymentId, SqlConnection sqlConnection)
        {

            command = new SqlCommand("sp_InsertOrderData", sqlConnection);
            command.CommandType = CommandType.StoredProcedure;

            command.Parameters.AddWithValue("@OrderNo", CartCrud.GetUniqueId());
            command.Parameters.AddWithValue("@PaymentId", paymentId);
            command.Parameters.AddWithValue("@CustomerId",sessionId);
            command.Parameters.AddWithValue("@ProductId",productId);
            command.Parameters.AddWithValue("@Quantity",Quantity);
            command.Parameters.AddWithValue("@Status", "Pending");

            command.ExecuteNonQuery();
            
        }
    }
}