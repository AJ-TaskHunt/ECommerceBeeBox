using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Web.Configuration;
using System.Data.SqlClient;
using System.Data;

namespace ECommerceBeeBox.Customer
{
    public partial class UpdateCustomer : System.Web.UI.Page
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
                else
                {
                    GetCustomerData();
                }
            }

            lblmsg.Visible = false;
        }

        public void GetCustomerData()
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();

                using (SqlCommand cmd = new SqlCommand("select * from Customer where CustomerId=@CustomerId", con))
                {
                    cmd.Parameters.AddWithValue("@CustomerId", Session["CustomerId"]);

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            imgProfile.ImageUrl = reader["ImageUrl"].ToString();

                            txtName.Text = reader["Name"].ToString();
                            txtAddress.Text = reader["Address"].ToString();
                            txtEmail.Text = reader["Email"].ToString();
                            txtMobile.Text = reader["Mobile"].ToString();
                            txtPostCode.Text = reader["PostCode"].ToString();
                        }
                    }

                }
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();
                using (SqlCommand cmd = new SqlCommand("sp_UpdateCustomerData", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@Id", Session["CustomerId"]);
                    cmd.Parameters.AddWithValue("@Name", txtName.Text);
                    cmd.Parameters.AddWithValue("@Address", txtAddress.Text);
                    cmd.Parameters.AddWithValue("@Email", txtEmail.Text);
                    cmd.Parameters.AddWithValue("@Mobile", txtMobile.Text);
                    cmd.Parameters.AddWithValue("@PostCode", txtPostCode.Text);

                    if (fuImageProfile.HasFile)
                    {
                        string updateImage = "YES";
                        cmd.Parameters.AddWithValue("@UpdateImage", updateImage);
                        string imagepath = "~/CustomerTemplate/images/User/" + fuImageProfile.FileName;

                        fuImageProfile.SaveAs(Server.MapPath("~/CustomerTemplate/images/User/" + fuImageProfile.FileName));

                        cmd.Parameters.AddWithValue("@ImageUrl", imagepath);

                    }
                    else
                    {
                        string updateImage = "NO";
                        cmd.Parameters.AddWithValue("@UpdateImage", updateImage);
                        cmd.Parameters.AddWithValue("@ImageUrl", DBNull.Value);

                    }

                    cmd.ExecuteNonQuery();

                    GetCustomerData();

                    //    lblmsg.Visible = true;
                    //    lblmsg.Text = "Profile Updated successfullly!";
                    //    lblmsg.CssClass = "alert alert-success";

                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "showSweetAlert();", true);

                }

            }
        }
    }
}

