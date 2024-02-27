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

using static ECommerceBeeBox.Customer.Model.CartCrud;
using ECommerceBeeBox.Customer.Model;
using System.Web.UI.WebControls.WebParts;
using System.Net;

namespace ECommerceBeeBox.Customer
{
    public partial class Games : System.Web.UI.Page
    {
        string connectionString = WebConfigurationManager.ConnectionStrings["connection"].ConnectionString.ToString();
        CartCrud cartCrud = new CartCrud();
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

                using (SqlCommand cmd = new SqlCommand("sp_DisplayProduct", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@CategoryName", "Games");

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

        protected void rGames_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int sessionId = Convert.ToInt32(Session["CustomerId"]);
            int productId = Convert.ToInt32(e.CommandArgument);

            if (Session["CustomerId"] != null)
            {
                bool isCartItemUpdated = false;

                int item = cartCrud.isItemExistsInCart(productId, sessionId);

                if (item == 0)
                {
                    //Add new item into Cart
                    using (SqlConnection con = new SqlConnection(connectionString))
                    {
                        con.Open();

                        using (SqlCommand cmd = new SqlCommand("sp_InsertCart", con))
                        {
                            cmd.CommandType = CommandType.StoredProcedure;

                            cmd.Parameters.AddWithValue("@ProductId", productId);
                            cmd.Parameters.AddWithValue("@CustomerId", sessionId);
                            cmd.Parameters.AddWithValue("@Qty", 1);

                            int addToCart = cmd.ExecuteNonQuery();
                            if (addToCart > 0)
                            {
                                ClientScript.RegisterStartupScript(this.GetType(), "alert", "ItemAddedToCart();", true);
                            }
                        }
                    }

                }
                else
                {
                    //Add existing item to cart
                    isCartItemUpdated = cartCrud.updateCartQuantity(item + 1, productId, sessionId);

                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "ItemAddedToCart();", true);
                }

                Session["cartCount"] = cartCrud.cartCount(sessionId);

            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "showSweetAlert();", true);
            }
        }
    }
}