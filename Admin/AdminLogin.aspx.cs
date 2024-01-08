using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Web.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Web.Security;

namespace ECommerceBeeBox.Admin
{
    public partial class AdminLogin : System.Web.UI.Page
    {
        string ConnectionString = WebConfigurationManager.ConnectionStrings["connection"].ConnectionString.ToString();

        SqlConnection con;
        SqlCommand cmd;
        protected void Page_Load(object sender, EventArgs e)
        {
            con = new SqlConnection(ConnectionString);
            con.Open();

            lblmsg.Visible = false;

            if (Session["AdminUser"] != null)
            {
                Response.Redirect("Default.aspx");
            }

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string AdminName = txtAdminName.Text.Trim();
            string AdminPassword = txtAdminPassword.Text.Trim();

            cmd = new SqlCommand("sp_AdminLogin", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.AddWithValue("@AdminName", AdminName);
            cmd.Parameters.AddWithValue("@AdminPassword", AdminPassword);

            SqlDataReader drAdmin = cmd.ExecuteReader();

            if (drAdmin.HasRows == true)
            {
                while (drAdmin.Read())
                {
                    string name = drAdmin["AdminName"].ToString();
                    string pass = drAdmin["AdminPassword"].ToString();

                    if ( name == AdminName && pass == AdminPassword)
                    {
                        Session["AdminUser"] = AdminName;

                        //FormsAuthentication.SetAuthCookie(AdminName, false);

                        Response.Redirect("Dashboard.aspx");

                    }
                    else
                    {
                        lblmsg.Visible = true;
                        lblmsg.Text = "Invalid username or password";
                        lblmsg.CssClass = "alert alert-danger";
                    }
                }
            }
            else
            {
                lblmsg.Visible = true;
                lblmsg.Text = "Invalid username or password";
                lblmsg.CssClass = "alert alert-danger";
            }
        }
    }
}