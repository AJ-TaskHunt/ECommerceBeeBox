using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Web.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.IO;
using System.Web.Services;

using static ECommerceBeeBox.Seller.Model.CheckData;
using ECommerceBeeBox.Seller.Model;
using System.Drawing;

namespace ECommerceBeeBox.Seller
{
    public partial class SellerRegistration : System.Web.UI.Page
    {
        string ConnectionString = WebConfigurationManager.ConnectionStrings["connection"].ConnectionString.ToString();

        SqlConnection con;
        SqlCommand cmd;

        CheckData cd = new CheckData();
        protected void Page_Load(object sender, EventArgs e)
        {
            con = new SqlConnection(ConnectionString);
            con.Open();

            if (!IsPostBack)
            {
                //ShowSellerInfo();
               // IsEmailRegistered(txtEmail.Text);
                //IsEmailAlreadyRegistered(txtEmail.Text);
            }

            lblmsg.Visible = false;
            lblnameCheck.Visible = false;

        }

        protected void btnSignUp_Click(object sender, EventArgs e)
        {
            if (!fuSellerImg.HasFile)
            {
                Response.Write("<script> alert('Please Select Image') </script>");
            }
            else
            {
                if (txtPassword.Text == txtConfirmPassword.Text)
                {
                    string imgName = "SellerTemplate/ProductImage/" + fuSellerImg.FileName;
                    fuSellerImg.SaveAs(Server.MapPath("~/SellerTemplate/ProductImage/" + fuSellerImg.FileName));

                    cmd = new SqlCommand("sp_InsertSellerData", con);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@Name", txtFullName.Text);
                    cmd.Parameters.AddWithValue("@Address", txtAddress.Text);
                    cmd.Parameters.AddWithValue("@Mobile", txtMobile.Text);
                    cmd.Parameters.AddWithValue("@email", txtEmail.Text);
                    cmd.Parameters.AddWithValue("@Image", imgName);
                    cmd.Parameters.AddWithValue("@GST", txtGSTNumber.Text);
                    cmd.Parameters.AddWithValue("@PAN", txtPANNumber.Text);
                    cmd.Parameters.AddWithValue("@BankName", txtBankName.Text);
                    cmd.Parameters.AddWithValue("@AccountNumber", txtAccountNumber.Text);
                    cmd.Parameters.AddWithValue("@Password", txtPassword.Text);

                    int ans = cmd.ExecuteNonQuery();

                    if (ans > 0)
                    {
                        Response.Write("<script> alert('Account Created Successfully! ') </script>");
                    }
                    else
                    {
                        Response.Write("<script> alert('Error in Inserting') </script>");
                    }
                }
                else
                {
                    Response.Write("<script> alert('Password Not Matched') </script>");
                }
            }
        }

        protected void txtFullName_TextChanged(object sender, EventArgs e)
        {
            if(cd.checkUserName(txtFullName.Text) == true)
            {
                lblnameCheck.Visible = true;
                lblnameCheck.Text = "This UserName is Registered";
                lblnameCheck.ForeColor = Color.Red;
            }
            else
            {
                lblnameCheck.Visible = false;
            }
        }
    }
}
