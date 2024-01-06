using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Web.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Web.UI.HtmlControls;

namespace ECommerceBeeBox.Customer
{
    public partial class Games : System.Web.UI.Page
    {
        string connectionString = WebConfigurationManager.ConnectionStrings["connection"].ConnectionString.ToString();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ProductGames();
                GamesCategories();
            }

            lblmsg.Visible = false;

        }

        public void GamesCategories()
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();

                using (SqlCommand cmd = new SqlCommand("select DISTINCT sub.SubCategoryName as SubCategoryName, cat.CategoryName  from Product p join SubCategory sub on p.SubCategoryId = sub.SubCategoryId join Category cat on p.CategoryId = cat.CategoryId where cat.CategoryName = 'Games' and (p.IsActive=1 and cat.IsActive=1 and sub.IsActive=1)", con))
                {
                    //cmd.Parameters.AddWithValue("@games", "Games");

                    using (SqlDataReader drGamesCat = cmd.ExecuteReader())
                    {
                        rGamesCategories.DataSource = drGamesCat;
                        rGamesCategories.DataBind();
                    }
                }
            }

        }

        public void ProductGames()
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();

                using (SqlCommand cmd = new SqlCommand("sp_DisplayGames", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@games", "Games");

                    using (SqlDataReader drGames = cmd.ExecuteReader())
                    {
                        if (drGames.HasRows)
                        {
                            rGames.DataSource = drGames;
                            rGames.DataBind();
                        }
                        else
                        {
                            rGames.Visible = false;
                            lblmsg.Visible = true;
                        }
                    }
                }
            }
        }
    }
}