using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Security.Principal;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace ECommerceBeeBox.Customer
{
    public partial class MyProfile : System.Web.UI.Page
    {
        string ConnectionString = WebConfigurationManager.ConnectionStrings["connection"].ConnectionString.ToString();

        SqlConnection con;
        protected void Page_Load(object sender, EventArgs e)
        {
            con = new SqlConnection(ConnectionString);
            con.Open();

            if (Session["CustomerId"] == null)
            {
                Response.Redirect("Login.aspx");
            }

            if (!IsPostBack)
            {
                GetCustomerProfile();
                GetCustomerData();
            }
        }

        public void GetCustomerProfile()
        {
            using (SqlCommand cmd = new SqlCommand("select * from Customer where CustomerId='" + Session["CustomerId"] + "' and IsActive=1 ", con))
            {
                using (SqlDataReader drProfile = cmd.ExecuteReader())
                {                  
                    if (drProfile.Read())
                    {
                        imgProfile.ImageUrl = drProfile["ImageUrl"].ToString();

                        Session["CustomerUser"] = drProfile["Name"].ToString();
                        lblCreateDate.Text = drProfile["CreateDate"].ToString();
                        //lblAddress.Text = drProfile["Address"].ToString();
                        lblEmail.Text = drProfile["Email"].ToString();
                        lblMobile.Text = drProfile["Mobile"].ToString();
                        //lblPostCode.Text = drProfile["PostCode"].ToString();

                    }

                    rCustomerBasicInfo.DataSource = drProfile;
                    rCustomerBasicInfo.DataBind();
                }
            }
        }

        public void GetCustomerData()
        {
            using (SqlCommand cmd = new SqlCommand("select * from Customer where CustomerId='" + Session["CustomerId"] + "' and IsActive=1 ", con))
            {
                using (SqlDataReader drProfile = cmd.ExecuteReader())
                {
                    rCustomerBasicInfo.DataSource = drProfile;
                    rCustomerBasicInfo.DataBind();
                }
            }
        }

        protected void lbtnEditDetails_Click(object sender, EventArgs e)
        {
            //using (SqlConnection con = new SqlConnection(ConnectionString))
            //{
            //    con.Open();

            //    using (SqlCommand cmd = new SqlCommand("select CustomerId from Customer where CustomerId=@CustomerId", con))
            //    {
            //        cmd.Parameters.AddWithValue("@CustomerId", Session["CustomerId"]);

            //        using (SqlDataReader reader = cmd.ExecuteReader())
            //        {
            //            if (reader.Read())
            //            {
            //                int id = Convert.ToInt32(reader["CustomerId"]);

            //                Response.Redirect("UpdateCustomer.aspx?id='" + id + "' ");

            //            }
            //        }
            //    }
            //}

            //Response.Redirect("UpdateCustomer.aspx?id='" + Session["CustomerId"] + "' ");

            Response.Redirect("UpdateCustomer.aspx");

        }

        protected void lbtnUpdatePassword_Click(object sender, EventArgs e)
        {
            Response.Redirect("ChangePassword.aspx");
        }
    }
}