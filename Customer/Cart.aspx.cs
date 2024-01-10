using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data.SqlClient;
using System.Web.Configuration;
using System.Data;

namespace ECommerceBeeBox.Customer
{
    public partial class Cart : System.Web.UI.Page
    {
        string connectionString = WebConfigurationManager.ConnectionStrings["connection"].ConnectionString.ToString();

        SqlConnection con;
        SqlCommand cmd;

        decimal TotalAmount = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            con = new SqlConnection(connectionString);
            con.Open();

            if (!IsPostBack)
            {
                //if (Session["CustomerId"] != null)
                //{
                CartItems();
                //}
                //else
                //{
                //    Response.Redirect("Login.aspx");
                //}
            }
        }

        public void CartItems()
        {
            int sessionId = Convert.ToInt32(Session["CustomerId"]);

            cmd = new SqlCommand("sp_DisplayCartItems", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@CustomerId", sessionId);

            SqlDataReader drCartItem = cmd.ExecuteReader();

            if (drCartItem.HasRows)
            {
                rCartItem.DataSource = drCartItem;
                rCartItem.DataBind();
            }
            else
            {
                rCartItem.Visible = false;
                lblCartEmpty.Visible = true;
            }

        }
        protected void rCartItem_ItemCommand(object source, RepeaterCommandEventArgs e)
        {

        }

        protected void rCartItem_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Label TotalPrice = e.Item.FindControl("lblTotalPrice") as Label;
                Label ProductPrice = e.Item.FindControl("lblPrice") as Label;
                TextBox Quantity = e.Item.FindControl("txtQty") as TextBox;

                try
                {
                    decimal totalPriceValue = decimal.Parse(TotalPrice.Text);
                    decimal productPriceValue = decimal.Parse(ProductPrice.Text);
                    decimal quantityValue = decimal.Parse(Quantity.Text);

                    decimal calcTotalPrice = productPriceValue * quantityValue;

                    TotalPrice.Text = calcTotalPrice.ToString();

                    TotalAmount += calcTotalPrice;

                    Session["TotalAmount"] = TotalAmount;
                    
                }               
                catch (Exception ex)
                {                    
                    //Response.Write($"An error occurred: {ex.Message}");
                }
            }
        }
    }
}