using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ECommerceBeeBox.Customer
{
    public partial class ReturnOrReplace : System.Web.UI.Page
    {
        string ConnectionString = WebConfigurationManager.ConnectionStrings["connection"].ConnectionString.ToString();
        SqlConnection con;
        SqlCommand cmd;
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

        protected void GetProductDetails()
        {
            cmd = new SqlCommand("select p.ProductName from Orders o inner join Product p on o.ProductId = p.ProductId where OrderDetailsId = @id", con);

            cmd.Parameters.AddWithValue("@id", Convert.ToInt32(Request.QueryString["id"]));

            SqlDataReader GetProductName = cmd.ExecuteReader();

            if (GetProductName.Read())
            {
                Session["PName"] = GetProductName["ProductName"];
            }

            GetProductName.Close();
        }

        protected void btnReturnOrReplace_Click(object sender, EventArgs e)
        {
            int orderId = Convert.ToInt32(Request.QueryString["id"]);
            int CustomerId = Convert.ToInt32(Session["CustomerId"]);

            cmd = new SqlCommand("sp_InsertReturnOrReplaceOrderData", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@CustomerId", CustomerId);
            cmd.Parameters.AddWithValue("@OrderId", orderId);
            cmd.Parameters.AddWithValue("@Message", txtMessage.Text);
            cmd.Parameters.AddWithValue("@Reasone", ddlReplace.SelectedItem.Text);
            cmd.Parameters.AddWithValue("@IsReturn", true);

            int result = cmd.ExecuteNonQuery();

            if (result > 0)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "OrderReplaced();", true);
            }
            else
            {
                Response.Redirect("<script> alert('Error'); </script>");
            }

            Session.Remove("PName");
        }
    }
}