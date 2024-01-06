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
    public partial class Default : System.Web.UI.Page
    {
        string connectionString = WebConfigurationManager.ConnectionStrings["connection"].ConnectionString.ToString();

        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                MainCategorie();
            }

        }

        public void MainCategorie()
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();

                using (SqlCommand cmd = new SqlCommand("select * from Category where IsActive=1", con))
                {

                    using (SqlDataReader drGamesCat = cmd.ExecuteReader())
                    {
                       rProductCategory.DataSource = drGamesCat;
                       rProductCategory.DataBind();
                    }
                }
            }
        }

        protected void lbtnCategory_Command(object sender, CommandEventArgs e)
        {
            string CatName = e.CommandArgument.ToString().Trim();

            switch (CatName)
            {
                case "Console":
                    Response.Redirect("Console.aspx");
                    break;
                case "Games":
                    Response.Redirect("Games.aspx");
                    break;
                case "Controller":
                    Response.Redirect("Controller.aspx");
                    break;
                default:
                    Response.Redirect("Default.aspx");
                    break;
            }
        }
    }
}