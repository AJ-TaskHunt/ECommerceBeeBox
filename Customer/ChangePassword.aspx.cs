using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Web.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Xml.Linq;

namespace ECommerceBeeBox.Customer
{
    public partial class ChangePassword : System.Web.UI.Page
    {
        string connectionString = WebConfigurationManager.ConnectionStrings["connection"].ConnectionString.ToString();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["CustomerId"] == null)
                {
                    Response.Redirect("Login.aspx");
                }
            }

            lblmsg.Visible = false;
        }


        public bool CheckPassword()
        {
            bool CurrentPassword = false;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();

                using (SqlCommand cmd = new SqlCommand("select Password from Customer where CustomerId=@CustomerId", con))
                {
                    cmd.Parameters.AddWithValue("@CustomerId", Session["CustomerId"]);

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            if (txtCurrentPssword.Text == reader["Password"].ToString())
                            {
                                CurrentPassword = true;
                            }
                        }
                    }

                    return CurrentPassword;
                }
            }
        }
        protected void btnChangePassword_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();
                using (SqlCommand cmd = new SqlCommand("update Customer set Password=@NewPassword where CustomerId=@Id", con))
                {
                    if (CheckPassword())
                    {
                        if (txtCurrentPssword.Text == txtNewPassword.Text || txtCurrentPssword.Text == txtConfirmPassword.Text)
                        {
                            lblmsg.Visible = true;
                            lblmsg.Text = "Current password and new password cannot be the same.";
                            lblmsg.CssClass = "text-danger";
                        }
                        else
                        {
                            if (txtNewPassword.Text == txtConfirmPassword.Text)
                            {
                                cmd.Parameters.AddWithValue("@Id", Session["CustomerId"]);
                                cmd.Parameters.AddWithValue("@NewPassword", txtNewPassword.Text);

                                cmd.ExecuteNonQuery();

                                //ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "swal('Password changed successfully!', 'Click OK to go back to Profile').then(function() { window.location.href = 'MyProfile.aspx'; });", true);

                                ClientScript.RegisterStartupScript(this.GetType(), "alert", "showSweetAlert();", true);


                                //Response.Redirect("MyProfile.aspx");

                                //lblmsg.Visible = true;
                                //lblmsg.Text = "Password Changed successfullly!";
                                //lblmsg.CssClass = "alert alert-success";
                            }
                            else
                            {
                                lblmsg.Visible = true;
                                lblmsg.Text = "Both Password not matched";
                                lblmsg.CssClass = "text-danger";
                            }
                        }
                    }
                    else
                    {
                        lblmsg.Visible = true;
                        lblmsg.Text = "Please enter Correct current Password.";
                        lblmsg.CssClass = "text-danger";

                    }
                }
            }
        }
    }
}