using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

namespace ECommerceBeeBox.Admin
{
    public partial class OrderCancelStatus : System.Web.UI.Page
    {
        string connectionStirng = WebConfigurationManager.ConnectionStrings["connection"].ConnectionString.ToString();

        SqlConnection con;
        SqlCommand cmd;
        protected void Page_Load(object sender, EventArgs e)
        {
            con = new SqlConnection(connectionStirng);
            con.Open();

            if (Session["AdminUser"] == null)
            {
                Response.Redirect("AdminLogin.aspx");
            }

            if (!IsPostBack)
            {
                OrderCancelDetails();
            }
        }

        public void OrderCancelDetails()
        {
            cmd = new SqlCommand("sp_CancelOrderData", con);
            cmd.CommandType = CommandType.StoredProcedure;

            SqlDataReader dr = cmd.ExecuteReader();

            rCancelOrderData.DataSource = dr;
            rCancelOrderData.DataBind();
        }

        protected void rCancelOrderData_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if(e.CommandName == "delete")
            {
                cmd = new SqlCommand("delete from CancelOrderByCustomer where Id = @Id",con);
                cmd.Parameters.AddWithValue("@Id", e.CommandArgument);

                cmd.ExecuteNonQuery();

                lblmsg.Visible = true;
                lblmsg.Text = "Record deleted successfully!";
                lblmsg.CssClass = "alert alert-success";

                OrderCancelDetails();
            }
        }
    }
}