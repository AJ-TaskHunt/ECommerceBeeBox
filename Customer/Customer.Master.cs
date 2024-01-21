using ECommerceBeeBox.Customer.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ECommerceBeeBox.Customer
{
    public partial class Customer : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!Request.Url.AbsoluteUri.ToString().Contains("Default.aspx"))
            {
                
                form1.Attributes.Add("class", "sub_page");

                //Load the Control
                //Control slider = (Control)Page.LoadControl("SliderUserControl.ascx");
                //pnlSlider.Controls.Add(slider);
            }
            else 
            {
                //form1.Attributes.Remove("class");

                //Load the Control
                Control slider = (Control)Page.LoadControl("SliderUserControl.ascx");
                pnlSlider.Controls.Add(slider);

                form1.Attributes.Add("class", "sub_page");

            }

            if (Session["CustomerId"] == null)
            {
                lbtnLoginOrLogout.Text = "Login";
            }
            else
            {
                lbtnLoginOrLogout.Text = "Logout";
            }

            CartCrud cart = new CartCrud();

            Session["cartCount"] = cart.cartCount(Convert.ToInt32(Session["CustomerId"]));

        }

        protected void lbtnLoginOrLogout_Click(object sender, EventArgs e)
        {
            if (Session["CustomerId"] == null)
            {
                Response.Redirect("Login.aspx");
            }
            else 
            {
                Session.Abandon();
                Response.Redirect("Login.aspx");
            }
        }
    }
}