using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data.SqlClient;
using System.Web.Configuration;
using System.Data;

namespace ECommerceBeeBox
{
    public partial class CustomerRegistration : System.Web.UI.Page
    {
        string connectionString = WebConfigurationManager.ConnectionStrings["connection"].ConnectionString.ToString();

        protected void Page_Load(object sender, EventArgs e)
        {
            lblmsg.Visible = false;
        }

        protected void btnSingUp_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();

                if (txtPassword.Text != txtConfirmPassword.Text)
                {
                    lblmsg.Visible = true;
                    lblmsg.Text = "Password dose not Matched";
                    lblmsg.CssClass = "alert alert-danger";
                }
                else
                {
                    using (SqlCommand cmd = new SqlCommand("sp_InsertCustomerData", con))
                    {
                        string imagePath = "~/CustomerTemplate/Images/User/Default.jpg";

                        cmd.CommandType = CommandType.StoredProcedure;

                        cmd.Parameters.AddWithValue("@Name", txtName.Text);
                        cmd.Parameters.AddWithValue("@Email", txtEmail.Text);
                        cmd.Parameters.AddWithValue("@Mobile", txtMobile.Text);
                        cmd.Parameters.AddWithValue("@Image", imagePath);
                        cmd.Parameters.AddWithValue("@Password", txtPassword.Text);

                        int result = cmd.ExecuteNonQuery();

                        if (result > 0)
                        {
                            lblmsg.Visible = true;
                            lblmsg.Text = "Registration Successfully!" + "\tGo to Login Page";
                            lblmsg.CssClass = "alert alert-success";
                        }
                        else
                        {
                            lblmsg.Visible = true;
                            lblmsg.Text = "Error";
                            lblmsg.CssClass = "alert alert-danger";
                        }
                    }
                }
            }
        }
    }
}