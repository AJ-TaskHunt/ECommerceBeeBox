using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Web.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Drawing;

namespace ECommerceBeeBox
{
    public partial class LoginForm : System.Web.UI.Page
    {
        string ConnectionString = WebConfigurationManager.ConnectionStrings["connection"].ConnectionString.ToString();

        SqlConnection con;
        protected void Page_Load(object sender, EventArgs e)
        {
            con = new SqlConnection(ConnectionString);
            con.Open();

            lblmsg.Visible = false;

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            using (SqlCommand cmd = new SqlCommand("sp_CustomerLogin", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Email", txtEmailOrMobile.Text);
                cmd.Parameters.AddWithValue("@Mobile",txtEmailOrMobile.Text);
                cmd.Parameters.AddWithValue("@Password", txtPassword.Text);

                using (SqlDataReader drCheckLogin = cmd.ExecuteReader())
                {
                    if (drCheckLogin.HasRows == true)
                    {
                        while (drCheckLogin.Read())
                        {
                            int CustomerId = Convert.ToInt32(drCheckLogin["CustomerId"].ToString()); 

                            string name = drCheckLogin["Name"].ToString();
                            string email = drCheckLogin["Email"].ToString();
                            string mobile = drCheckLogin["Mobile"].ToString();
                            string password = drCheckLogin["Password"].ToString();


                            if ((email == txtEmailOrMobile.Text || mobile == txtEmailOrMobile.Text)  && password == txtPassword.Text)
                            {
                                Session["CustometId"] = CustomerId;
                                Session["CustomerUser"] = name;
                                Session["CustomerEmail"] = email;

                                Response.Write("<script> alert('Login Successfully!'); </script>");

                                //Response.Redirect("~/Seller/Dashboard.aspx");
                            }
                            else
                            {
                                lblmsg.Visible = true;
                                lblmsg.Text = "Incorrect Email/Mobile or Password";
                                lblmsg.ForeColor = Color.Red;
                            }
                        }
                    }
                    else
                    {
                        lblmsg.Visible = true;
                        lblmsg.Text = "Incorrect Email/Mobile or Password";
                        lblmsg.ForeColor = Color.Red;
                    }
                }
            }




        }
    }
}