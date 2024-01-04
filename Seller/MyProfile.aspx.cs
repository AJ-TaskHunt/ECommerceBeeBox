using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data.SqlClient;
using System.Data;
using System.Web.Configuration;

namespace ECommerceBeeBox.Seller
{
    public partial class MyProfile : System.Web.UI.Page
    {
        string ConnectionString = WebConfigurationManager.ConnectionStrings["connection"].ConnectionString.ToString();

        SqlConnection con;
        protected void Page_Load(object sender, EventArgs e)
        {
            con = new SqlConnection(ConnectionString);
            con.Open();

            if(!IsPostBack)
            {
                GetSellerProfile();
            }
        }

            public void GetSellerProfile()
            {
                using (SqlCommand cmd = new SqlCommand("select * from Seller where Email='"+ Session["Email"] +"' and IsActive=1 ",con))
                {
                    using (SqlDataReader drProfile = cmd.ExecuteReader())
                    {
                        if(drProfile.Read())
                        {
                            imgProfile.ImageUrl = "~/SellerTemplate/ProductImage/" +  drProfile["ImageUrl"].ToString();
                            lblCreatedDate.Text = drProfile["CreateDate"].ToString();

                            txtName.Text = drProfile["Name"].ToString();
                            txtAddress.Text = drProfile["Address"].ToString();
                            txtEmail.Text = drProfile["Email"].ToString();
                            txtMobile.Text = drProfile["Mobile"].ToString();
                            txtBankName.Text = drProfile["BankName"].ToString();
                            txtAccount.Text = drProfile["BankAccountNumber"].ToString();
                            txtGST.Text = drProfile["GSTNumber"].ToString();
                            txtPAN.Text = drProfile["PANNumber"].ToString();
                        }
                    }
                }
            }
    }
}