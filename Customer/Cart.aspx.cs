using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data.SqlClient;
using System.Web.Configuration;
using System.Data;
using static ECommerceBeeBox.Customer.Model.CartCrud;
using ECommerceBeeBox.Customer.Model;

namespace ECommerceBeeBox.Customer
{
    public partial class Cart : System.Web.UI.Page
    {
        string connectionString = WebConfigurationManager.ConnectionStrings["connection"].ConnectionString.ToString();

        SqlConnection con;
        SqlCommand cmd;
        CartCrud cart = new CartCrud();

        decimal TotalAmount = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            con = new SqlConnection(connectionString);
            con.Open();

            if (!IsPostBack)
            {
                if (Session["CustomerId"] != null)
                {
                    CartItems();
                }
                else
                {
                    Response.Redirect("Login.aspx");
                }
            }
        }

        public void CartItems()
        {
            int sessionId = Convert.ToInt32(Session["CustomerId"]);

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("sp_DisplayCartItems", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@CustomerId", sessionId);

                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dtCartItem = new DataTable();
                        da.Fill(dtCartItem);

                        if (dtCartItem.Rows.Count > 0)
                        {
                            rCartItem.DataSource = dtCartItem;
                            rCartItem.DataBind();
                        }
                        else
                        {
                            rCartItem.Visible = false;
                            lblCartEmpty.Visible = true;
                        }
                    }
                }
            }


            Session["cartCount"] = cart.cartCount(sessionId);


        }
        protected void rCartItem_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int sessionId = Convert.ToInt32(Session["CustomerId"]);

            if (e.CommandName == "remove")
            {
                int ProductId = Convert.ToInt32(e.CommandArgument);

                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    con.Open();

                    using (SqlCommand cmd = new SqlCommand("sp_DeleteCartItem", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@ProductId", ProductId);
                        cmd.Parameters.AddWithValue("@CustomerId", sessionId);

                        cmd.ExecuteNonQuery();
                        CartItems();
                    }
                }
            }

            if (e.CommandName == "UpdateCart")
            {
                bool isCartUpdated = false;

                for (int item = 0; item < rCartItem.Items.Count; item++)
                {
                    if (rCartItem.Items[item].ItemType == ListItemType.Item || rCartItem.Items[item].ItemType == ListItemType.AlternatingItem)
                    {
                        TextBox quantity = rCartItem.Items[item].FindControl("txtQty") as TextBox;

                        HiddenField pId = rCartItem.Items[item].FindControl("hfProductId") as HiddenField;
                        HiddenField pQty = rCartItem.Items[item].FindControl("hfQuantity") as HiddenField;

                        int quantityFromCart = Convert.ToInt32(quantity.Text);
                        int hfPID = Convert.ToInt32(pId.Value);
                        int QtyFromDB = Convert.ToInt32(pQty.Value);

                        bool isTrue = false;

                        int updatedQuantity = 1;

                        if (quantityFromCart > QtyFromDB || quantityFromCart < QtyFromDB)
                        {
                            updatedQuantity = quantityFromCart;
                            isTrue = true;

                        }

                        //cart.updateCartQuantity(updatedQuantity, hfPID, sessionId);
                        //ClientScript.RegisterStartupScript(this.GetType(), "alert", "CartUpdated();", true);

                        

                        if (isTrue)
                        {
                            isCartUpdated = cart.updateCartQuantity(updatedQuantity, hfPID, sessionId);
                            CartItems();
                            isCartUpdated = true;
                        }

                        if (isCartUpdated)
                        {
                            ClientScript.RegisterStartupScript(this.GetType(), "alert", "CartUpdated();", true);
                        }
                    }
                }
            }
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