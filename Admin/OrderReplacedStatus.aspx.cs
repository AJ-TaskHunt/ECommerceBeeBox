using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ECommerceBeeBox.Admin
{
    public partial class OrderReplacedStatus : System.Web.UI.Page
    {
        string ConnectionString = WebConfigurationManager.ConnectionStrings["connection"].ConnectionString.ToString();
        SqlConnection con;
        SqlCommand cmd;
        protected void Page_Load(object sender, EventArgs e)
        {
            con = new SqlConnection(ConnectionString);
            con.Open();

            if (Session["AdminUser"] == null)
            {
                Response.Redirect("AdminLogin.aspx");
            }

            if (!IsPostBack)
            {
                OrderReplacedDetails();
            }
        }

        private void OrderReplacedDetails()
        {
            cmd = new SqlCommand("select ROW_NUMBER() over(order by (select 1)) as SrNo, r.*, c.Name, c.Email, o.OrderNo  from ReturnOrReplaceOrder r inner join Customer c on r.CustomerId = c.CustomerId inner join Orders o on  r.OrderId = o.OrderDetailsId", con);

            SqlDataReader dr = cmd.ExecuteReader();

            rReplaceOrderData.DataSource = dr;
            rReplaceOrderData.DataBind();
        }

        protected void rReplaceOrderData_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "delete")
            {
                cmd = new SqlCommand("delete from ReturnOrReplaceOrder where ReturnOrReplaceId = @Id", con);
                cmd.Parameters.AddWithValue("@Id", e.CommandArgument);

                cmd.ExecuteNonQuery();

                lblmsg.Visible = true;
                lblmsg.Text = "Record deleted successfully!";
                lblmsg.CssClass = "alert alert-success";

                OrderReplacedDetails();
            }

        }
    }
}