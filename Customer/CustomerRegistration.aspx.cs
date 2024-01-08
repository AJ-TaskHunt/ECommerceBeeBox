using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Configuration;

namespace ECommerceBeeBox.Customer
{
    public partial class CustomerRegistration : System.Web.UI.Page
    {
        string connectionString = WebConfigurationManager.ConnectionStrings["connection"].ConnectionString.ToString();

        protected void Page_Load(object sender, EventArgs e)
        {
            lblmsg.Visible = false;

            string imagePath = "~/CustomerTemplate/images/User/Default.png";
            imgProfile.ImageUrl = imagePath;
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            clear();
        }

        public void clear()
        {
            txtName.Text = string.Empty;
            txtAddress.Text = string.Empty;
            txtMobile.Text = string.Empty;
            txtEmail.Text = string.Empty;
            txtPostCode.Text = string.Empty;
            txtPassword.Text = string.Empty;
            txtConfirmPassword.Text = string.Empty;

            fuImageProfile.AccessKey = string.Empty;

        }

        protected void btnSignUp_Click(object sender, EventArgs e)
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
                        cmd.CommandType = CommandType.StoredProcedure;

                        cmd.Parameters.AddWithValue("@Name", txtName.Text.Trim());
                        cmd.Parameters.AddWithValue("@Address", txtAddress.Text.Trim());
                        cmd.Parameters.AddWithValue("@PostCode", txtPostCode.Text.Trim());
                        cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                        cmd.Parameters.AddWithValue("@Mobile", txtMobile.Text.Trim());
                        cmd.Parameters.AddWithValue("@Password", txtPassword.Text.Trim());

                        if (fuImageProfile.HasFile)
                        {
                            string imagePath = "~/CustomerTemplate/images/User/" + fuImageProfile.FileName;
                            fuImageProfile.SaveAs(Server.MapPath("~/CustomerTemplate/images/User/" + fuImageProfile.FileName));

                            cmd.Parameters.AddWithValue("@Image", imagePath);
                        }
                        else
                        {
                            string imagePath = "~/CustomerTemplate/images/User/Default.png";
                            cmd.Parameters.AddWithValue("@Image", imagePath);
                        }

                        int result = cmd.ExecuteNonQuery();

                        if (result > 0)
                        {
                            lblmsg.Visible = true;
                            lblmsg.Text = "Registration Successfully!" + "\tGo to Login Page";
                            lblmsg.CssClass = "alert alert-success";

                            clear();
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
