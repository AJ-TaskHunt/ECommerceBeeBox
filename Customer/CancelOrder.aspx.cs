using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data.SqlClient;
using System.Web.Configuration;
using System.Data;
using Org.BouncyCastle.Asn1.Ocsp;

namespace ECommerceBeeBox.Customer
{
    public partial class CancelOrder : System.Web.UI.Page
    {
        string ConnectionString = WebConfigurationManager.ConnectionStrings["connection"].ConnectionString.ToString();
        SqlConnection con;
        SqlCommand cmd;
        int Productid = 0, Quantity=0;
        protected void Page_Load(object sender, EventArgs e)
        {
            con = new SqlConnection(ConnectionString);
            con.Open();

            if (Session["CustomerId"] == null && Request.QueryString["id"] == null)
            {
                Response.Redirect("Login.aspx");
            }
            else
            {
                GetProductDetails();
            }
        }

        protected void btnCancelOrder_Click(object sender, EventArgs e)
        {
            int orderId = Convert.ToInt32(Request.QueryString["id"]);
            int CustomerId = Convert.ToInt32(Session["CustomerId"]);

            cmd = new SqlCommand("sp_InsertOrderCancelData", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@CustomerId",CustomerId);
            cmd.Parameters.AddWithValue("@OrderId",orderId);
            cmd.Parameters.AddWithValue("@Message", txtMessage.Text);
            cmd.Parameters.AddWithValue("@IsCancel",false);

            int result = cmd.ExecuteNonQuery();

            if(result > 0)
            {
                UpdateQty(orderId);

                ClientScript.RegisterStartupScript(this.GetType(), "alert", "OrderCancel();", true);
            }
            else
            {
                Response.Redirect("<script> alert('Error'); </script>");
            }
        }

        protected void UpdateQty(int OrderId)
        {
            cmd = new SqlCommand("select ProductId,Quantity from Orders where OrderDetailsId=@OrderId", con);
            cmd.Parameters.AddWithValue("OrderId",OrderId);
            SqlDataReader rdr = cmd.ExecuteReader();

            if(rdr.Read())   
            {
                Productid = Convert.ToInt32(rdr["ProductId"].ToString());
                Quantity = Convert.ToInt32(rdr["Quantity"].ToString());

                ProductTableQty(Productid, Quantity);
            }
            rdr.Close();
        }

        protected void ProductTableQty(int pid, int Qty)
        {
            cmd = new SqlCommand("update Product set Quantity = Quantity + @Qty where ProductId=@pid",con);
            cmd.Parameters.AddWithValue("@pid",pid);
            cmd.Parameters.AddWithValue("@Qty",Qty);

            cmd.ExecuteNonQuery();
        }

        protected void GetProductDetails()
        {
            cmd = new SqlCommand("select p.ProductName from Orders o inner join Product p on o.ProductId = p.ProductId where OrderDetailsId = @id",con);

            cmd.Parameters.AddWithValue("@id", Convert.ToInt32(Request.QueryString["id"]));

            SqlDataReader GetProductName = cmd.ExecuteReader();

            if(GetProductName.Read())
            {
                Session["PName"] = GetProductName["ProductName"];
            }
        }
    }
}