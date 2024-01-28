using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data.SqlClient;
using System.Data;
using System.Web.Configuration;
using System.Drawing;
using System.IO;

namespace ECommerceBeeBox.Admin
{
    public partial class ManageCustomer : System.Web.UI.Page
    {
        string connectionStirng = WebConfigurationManager.ConnectionStrings["connection"].ConnectionString.ToString();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["AdminUser"] == null)
            {
                Response.Redirect("AdminLogin.aspx");
            }

            if (!IsPostBack)
            {
                GetCustomerInfo();
            }

            /* btnUpdate.Visible = false;
             btnClear.Text = "Reset";
             imgCustomer.Visible = true;
             lblmsg.Visible = false;

             txtPassIcon.Visible = false; */

        }

        private void GetCustomerInfo()
        {
            using (SqlConnection con = new SqlConnection(connectionStirng))
            {
                con.Open();

                using (SqlCommand cmd = new SqlCommand("sp_DisplayCustomerData", con))
                {
                    using (SqlDataReader drGetCustomerInfo = cmd.ExecuteReader())
                    {
                        rCustomerData.DataSource = drGetCustomerInfo;
                        rCustomerData.DataBind();
                    }

                }
            }
        }

        /* private void clear()
         {
             txtName.Text = string.Empty;
             txtAddress.Text = string.Empty;
             txtMobile.Text = string.Empty;
             txtEmail.Text = string.Empty;
             txtPostCode.Text = string.Empty;
             txtPassword.Text = string.Empty;
             cbIsActive.Checked = false;

             imgCustomer.Visible = false;

         }*/

        /* protected void btnAdd_Click(object sender, EventArgs e)
         {
             using (SqlConnection con = new SqlConnection(connectionStirng))
             {
                 con.Open();

                 using (SqlCommand cmd = new SqlCommand("sp_InsertCustomerDataByAdmin", con))
                 {
                     cmd.CommandType = CommandType.StoredProcedure;

                     if (fuCustomerImage.HasFile)
                     {
                         cmd.Parameters.AddWithValue("@Name", txtName.Text);
                         cmd.Parameters.AddWithValue("@Email", txtEmail.Text);
                         cmd.Parameters.AddWithValue("@Mobile", txtMobile.Text);
                         cmd.Parameters.AddWithValue("@Address", txtAddress.Text);
                         cmd.Parameters.AddWithValue("@PostCode", txtPostCode.Text);
                         cmd.Parameters.AddWithValue("@IsActive", cbIsActive.Checked);
                         cmd.Parameters.AddWithValue("@Password", txtPassword.Text);

                         string imagePath = "~/CustomerTemplate/Images/User/" + fuCustomerImage.FileName;
                         fuCustomerImage.SaveAs(Server.MapPath("~/CustomerTemplate/Images/User/" + fuCustomerImage.FileName));

                         cmd.Parameters.AddWithValue("@ImageUrl", imagePath);

                         int result = cmd.ExecuteNonQuery();

                         if (result > 0)
                         {
                             lblmsg.Visible = true;
                             lblmsg.Text = "Customer Added successfully!";
                             lblmsg.CssClass = "alert alert-success";

                             clear();

                             GetCustomerInfo();
                         }
                         else
                         {

                             lblmsg.Visible = true;
                             lblmsg.Text = "Customer Added Unsuccessfully!";
                             lblmsg.CssClass = "alert alert-danger";

                         }
                     }
                     else
                     {
                         lblmsg.Visible = true;
                         lblmsg.Text = "Please Select Image";
                         lblmsg.CssClass = "alert alert-primary";
                     }
                 }
             }
         } */

        /* protected void btnUpdate_Click(object sender, EventArgs e)
         {
             HttpPostedFile imgName = fuCustomerImage.PostedFile;

             if (imgName != null && imgName.ContentLength > 0)
             {
                 string fileName = Path.GetFileName(fuCustomerImage.FileName);
                 string uploadFolderPath = Server.MapPath("~/CustomerTemplate/Images/User/");
                 string filePath = Path.Combine(uploadFolderPath, fileName);
                 fuCustomerImage.SaveAs(filePath);

                 using (SqlConnection con = new SqlConnection(connectionStirng))
                 {
                     con.Open();

                     using (SqlCommand cmd = new SqlCommand("sp_UpdateCustomerData", con))
                     {
                         cmd.CommandType = CommandType.StoredProcedure;

                         // Check if image needs to be updated
                         string updateImage = "YES";
                         cmd.Parameters.AddWithValue("@UpdateImage", updateImage);

                         cmd.Parameters.AddWithValue("@Id", hfCustomerId.Value);
                         cmd.Parameters.AddWithValue("@Name", txtName.Text);
                         cmd.Parameters.AddWithValue("@Address", txtAddress.Text);
                         cmd.Parameters.AddWithValue("@Email", txtEmail.Text);
                         cmd.Parameters.AddWithValue("@Mobile", txtMobile.Text);
                         cmd.Parameters.AddWithValue("@PostCode", txtPostCode.Text);
                         cmd.Parameters.AddWithValue("@Password", txtPassIcon.Text);
                         cmd.Parameters.AddWithValue("@IsActive", cbIsActive.Checked);
                         cmd.Parameters.AddWithValue("@ImageUrl", fileName);

                         cmd.ExecuteNonQuery();

                         clear();

                         GetCustomerInfo();
                     }
                 }
             }
             else
             {
                 using (SqlConnection con = new SqlConnection(connectionStirng))
                 {
                     con.Open();

                     using (SqlCommand cmd = new SqlCommand("sp_UpdateCustomerData", con))
                     {
                         cmd.CommandType = CommandType.StoredProcedure;

                         // Check if image needs to be updated
                         string updateImage = "NO";
                         cmd.Parameters.AddWithValue("@UpdateImage", updateImage);

                         cmd.Parameters.AddWithValue("@Id", hfCustomerId.Value);
                         cmd.Parameters.AddWithValue("@Name", txtName.Text);
                         cmd.Parameters.AddWithValue("@Address", txtAddress.Text);
                         cmd.Parameters.AddWithValue("@Email", txtEmail.Text);
                         cmd.Parameters.AddWithValue("@Mobile", txtMobile.Text);
                         cmd.Parameters.AddWithValue("@PostCode", txtPostCode.Text);
                         cmd.Parameters.AddWithValue("@Password", txtPassIcon.Text);
                         cmd.Parameters.AddWithValue("@IsActive", cbIsActive.Checked);
                         cmd.Parameters.AddWithValue("@ImageUrl", DBNull.Value);

                         cmd.ExecuteNonQuery();

                         clear();

                         GetCustomerInfo();

                     }
                 }
             }

             lblmsg.Visible = true;
             lblmsg.Text = "Customer Information updated successfully!";
             lblmsg.CssClass = "alert alert-success";

             btnAdd.Visible = true;
             txtPassIcon.Visible = false;
             txtPassword.Visible = true;
         }

         protected void btnClear_Click(object sender, EventArgs e)
         {
             clear();

             txtPassword.Visible = true;
             btnAdd.Visible = true;
             PassIcon.Visible = true;
         } */

        protected void rCustomerData_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            /* if (e.CommandName == "edit")
             {
                 //txtPassIcon.Visible = true;
                 // txtPassword.Visible = false;
                 // PassIcon.Visible = false;

                 using (SqlConnection con = new SqlConnection(connectionStirng))
                 {
                     con.Open();
                     using (SqlCommand cmd = new SqlCommand("select * from Customer where CustomerId='" + e.CommandArgument + "' ", con))
                     {
                         using (SqlDataReader drEditCustomer = cmd.ExecuteReader())
                         {
                             if (drEditCustomer.Read())
                             {
                                 hfCustomerId.Value = drEditCustomer["CustomerId"].ToString();
                                 imgCustomer.ImageUrl = drEditCustomer["ImageUrl"].ToString();

                                 txtName.Text = drEditCustomer["Name"].ToString();
                                 txtAddress.Text = drEditCustomer["Address"].ToString();
                                 txtEmail.Text = drEditCustomer["Email"].ToString();
                                 txtPostCode.Text = drEditCustomer["PostCode"].ToString();
                                 txtMobile.Text = drEditCustomer["Mobile"].ToString();
                                 txtPassIcon.Text = drEditCustomer["Password"].ToString();

                                 cbIsActive.Checked = Convert.ToBoolean(drEditCustomer["IsActive"].ToString());
                             }
                         }
                     }
                 }

                 btnAdd.Visible = false;
                 btnUpdate.Visible = true;
                 btnClear.Text = "Cancel";

             }*/

            int customerId = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "delete")
            {
                using (SqlConnection con = new SqlConnection(connectionStirng))
                {
                    con.Open();
                    using (SqlCommand cmd = new SqlCommand("delete from Customer where CustomerId='" + customerId + "' ", con))
                    {
                        int delete = cmd.ExecuteNonQuery();

                        lblmsg.Visible = true;
                        lblmsg.Text = "Customer deleted Successfully!";
                        lblmsg.CssClass = "alert alert-success";

                        GetCustomerInfo();
                    }
                }
            }

            /* ============================================================================================================================= */

            if (e.CommandName == "unblock")
            {
                using (SqlConnection con = new SqlConnection(connectionStirng))
                {
                    con.Open();

                    using (SqlCommand checkCmd = new SqlCommand("SELECT * FROM Customer WHERE IsActive=@ISActive and CustomerId = @CustomerId", con))
                    {
                        checkCmd.Parameters.AddWithValue("@CustomerId", customerId);
                        checkCmd.Parameters.AddWithValue("@IsActive", true);

                        SqlDataReader reader = checkCmd.ExecuteReader();

                        if (reader.Read())
                        {
                            lblmsg.Visible = true;
                            lblmsg.Text = "Customer is already unblocked";
                            lblmsg.CssClass = "alert alert-warning";
                        }
                        else
                        {
                            reader.Close();

                            using (SqlCommand cmd = new SqlCommand("UPDATE Customer SET IsActive = @IsActive WHERE CustomerId = @CustomerId", con))
                            {
                                cmd.Parameters.AddWithValue("@IsActive", true);
                                cmd.Parameters.AddWithValue("@CustomerId", customerId);

                                int rowsAffected = cmd.ExecuteNonQuery();

                                if (rowsAffected > 0)
                                {
                                    lblmsg.Visible = true;
                                    lblmsg.Text = "Customer is ublocked";
                                    lblmsg.CssClass = "alert alert-success";

                                    GetCustomerInfo();
                                }
                                else
                                {
                                    lblmsg.Visible = true;
                                    lblmsg.Text = "Failed to unblock the Customer";
                                    lblmsg.CssClass = "alert alert-danger";
                                }
                            }
                        }
                    }
                }
            }


            /* ============================================================================================================================= */

            if (e.CommandName == "block")
            {
                using (SqlConnection con = new SqlConnection(connectionStirng))
                {
                    con.Open();

                    using (SqlCommand checkCmd = new SqlCommand("SELECT * FROM Customer WHERE IsActive=@ISActive and CustomerId = @CustomerId", con))
                    {
                        checkCmd.Parameters.AddWithValue("@CustomerId", customerId);
                        checkCmd.Parameters.AddWithValue("@IsActive", false);

                        SqlDataReader reader = checkCmd.ExecuteReader();

                        if (reader.Read())
                        {

                            lblmsg.Visible = true;
                            lblmsg.Text = "Customer is already blocked";
                            lblmsg.CssClass = "alert alert-warning";
                        }
                        else
                        {

                            reader.Close();

                            using (SqlCommand cmd = new SqlCommand("UPDATE Customer SET IsActive = @IsActive WHERE CustomerId = @CustomerId", con))
                            {
                                cmd.Parameters.AddWithValue("@IsActive", false);
                                cmd.Parameters.AddWithValue("@CustomerId", customerId);

                                int rowsAffected = cmd.ExecuteNonQuery();

                                if (rowsAffected > 0)
                                {
                                    lblmsg.Visible = true;
                                    lblmsg.Text = "Customer is blocked";
                                    lblmsg.CssClass = "alert alert-danger";

                                    GetCustomerInfo();
                                }
                                else
                                {
                                    lblmsg.Visible = true;
                                    lblmsg.Text = "Failed to block the Customer";
                                    lblmsg.CssClass = "alert alert-danger";
                                }
                            }
                        }
                    }
                }
            }

        }
    }
}
