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

namespace ECommerceBeeBox.Seller
{
    public partial class Register : System.Web.UI.Page
    {
        string ConnectionString = WebConfigurationManager.ConnectionStrings["connection"].ConnectionString.ToString();

        SqlConnection con;
        SqlCommand cmd;
        protected void Page_Load(object sender, EventArgs e)
        {
            con = new SqlConnection(ConnectionString);
            con.Open();

            if (!IsPostBack)
            {
                //ShowSellerInfo();
            }

            lblmsg.Visible = false;
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
                    string imgName = "AdminTemplate/ProductImage/" + fuSellerImg.FileName;
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
    }
}