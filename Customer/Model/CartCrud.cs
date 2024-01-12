using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Web.Configuration;
using System.Data.SqlClient;
using System.Data;

namespace ECommerceBeeBox.Customer.Model
{
    public class CartCrud
    {
        string connectionString = WebConfigurationManager.ConnectionStrings["connection"].ConnectionString.ToString();

        public int isItemExistsInCart(int ProductId, int sessionId)
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();

                using (SqlCommand cmd = new SqlCommand("select * from Cart where ProductId= @ProductId and CustomerId=@CustomerId", con))
                {
                    cmd.Parameters.AddWithValue("@ProductId", ProductId);
                    cmd.Parameters.AddWithValue("@CustomerId", sessionId);

                    using (SqlDataReader drCheckCartItem = cmd.ExecuteReader())
                    {
                        int Qty = 0;
                        if (drCheckCartItem.Read())
                        {
                            Qty = Convert.ToInt32(drCheckCartItem["Quantity"].ToString());

                            //ClientScript.RegisterStartupScript(this.GetType(), "alert", "CartItemExists();", true);
                        }
                        return Qty;
                    }
                }
            }
        }

        public bool updateCartQuantity(int qty, int productId, int CustomerId)
        {
            bool isUpdated = false;
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();

                using (SqlCommand cmd = new SqlCommand("sp_UpdateCart", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@ProductId", productId);
                    cmd.Parameters.AddWithValue("@CustomerId", CustomerId);
                    cmd.Parameters.AddWithValue("@Qty", qty);

                    cmd.ExecuteNonQuery();

                    isUpdated = true;
                }
            }

            return isUpdated;
        }

        public int cartCount(int CustomerId)
        {
            int itemCount = 0;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();

                using (SqlCommand cmd = new SqlCommand("select count(*) from Cart where CustomerId=@CustomerId", con))
                {                    
                    cmd.Parameters.AddWithValue("@CustomerId", CustomerId);

                    using (SqlDataReader drCheckCartItem = cmd.ExecuteReader())
                    {

                        if(drCheckCartItem.Read())
                        {
                            itemCount = drCheckCartItem.GetInt32(0);

                        }
                    }
                }
            }

            return itemCount;
        }
    }
}