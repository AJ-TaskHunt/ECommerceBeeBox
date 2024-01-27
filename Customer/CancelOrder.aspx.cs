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
        protected void Page_Load(object sender, EventArgs e)
        {
            con = new SqlConnection(ConnectionString);
            con.Open();

            if (Session["CustomerId"] == null && Request.QueryString["id"] == null)
            {
                Response.Redirect("Login.aspx");
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
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "OrderCancel();", true);
            }
            else
            {
                Response.Redirect("<script> alert('Error'); </script>");
            }
        }
    }
}