using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data.SqlClient;
using System.Web.Configuration;
using System.Data;

namespace ECommerceBeeBox.Admin
{
    public partial class OrderStatus : System.Web.UI.Page
    {
        string connectionString = WebConfigurationManager.ConnectionStrings["Connection"].ConnectionString.ToString();

        SqlConnection con;
        SqlCommand cmd;
        protected void Page_Load(object sender, EventArgs e)
        {
            con = new SqlConnection(connectionString);
            con.Open();

            if (!IsPostBack)
            {
                if (Session["AdminUser"] != null)
                {
                    GetOrderDetails();
                }
                else
                {
                    Response.Redirect("AdminLogin.aspx");
                }
            }

            lblmsg.Visible = false;
            pUpdateOrderStatus.Visible = false;
        }

        public void GetOrderDetails()
        {
            cmd = new SqlCommand("sp_GetOrderStatus", con);
            cmd.CommandType = CommandType.StoredProcedure;

            SqlDataReader dr = cmd.ExecuteReader();

            rOrderList.DataSource = dr;
            rOrderList.DataBind();


        }

        protected void rOrderList_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if(e.CommandName == "edit")            {
               
                cmd = new SqlCommand("select * from Orders where OrderDetailsId = @OrderId",con);

                cmd.Parameters.AddWithValue("@OrderId", e.CommandArgument);

                SqlDataReader drOrderStatus = cmd.ExecuteReader();

                if(drOrderStatus.Read())
                {
                    hfOrderId.Value = Convert.ToInt32(drOrderStatus["OrderDetailsId"]).ToString();
                    ddlOrderStatus.SelectedValue = drOrderStatus["Status"].ToString();
                }

                pUpdateOrderStatus.Visible = true;
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            cmd = new SqlCommand("sp_UpdateOrderStatus", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.AddWithValue("@OrderId", hfOrderId.Value);
            cmd.Parameters.AddWithValue("@OrderStatus", ddlOrderStatus.SelectedValue);

            cmd.ExecuteNonQuery();

            lblmsg.Visible = true;
            lblmsg.Text = "Order Status Updated";
            lblmsg.CssClass = "alert alert-success";

            GetOrderDetails();
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            ddlOrderStatus.SelectedIndex = 0;
        }
    }
}