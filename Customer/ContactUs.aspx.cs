using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data.SqlClient;
using System.Data;
using System.Web.Configuration;

namespace ECommerceBeeBox.Customer
{
    public partial class ContactUs : System.Web.UI.Page
    {
        string connectionString = WebConfigurationManager.ConnectionStrings["Connection"].ConnectionString.ToString();

        SqlConnection con;
        SqlCommand cmd;
        protected void Page_Load(object sender, EventArgs e)
        {
                
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    con.Open();

                    using (SqlCommand cmd = new SqlCommand("sp_ContactUs", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;

                        cmd.Parameters.AddWithValue("@Name", txtName.Text.Trim());
                        cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                        cmd.Parameters.AddWithValue("@Subject", txtSubject.Text.Trim());
                        cmd.Parameters.AddWithValue("@Message", txtMessage.Text.Trim());

                        int result = cmd.ExecuteNonQuery();

                        if (result > 0)
                        {
                            ClientScript.RegisterStartupScript(this.GetType(), "alert", "ContactUs();", true);

                            txtEmail.Text = string.Empty;
                            txtSubject.Text = string.Empty;
                            txtMessage.Text = string.Empty;
                            txtName.Text = string.Empty;
                        }
                        else
                        {
                            Response.Write("<script>alert('Error');</script>");
                            txtEmail.Text = string.Empty;
                            txtSubject.Text = string.Empty;
                            txtMessage.Text = string.Empty;
                            txtName.Text = string.Empty;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // Handle exceptions, log errors, etc.
                Response.Write($"<script>alert('An error occurred: {ex.Message}');</script>");
            }

        }
    }
}