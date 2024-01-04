using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ECommerceBeeBox.Admin
{
    public partial class Admin : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            lbtnLogout.Text = "Logout";
        }

        protected void lbtnLogout_Click(object sender, EventArgs e)
        {
            if (Session["AdminUser"] == null)
            {
                Response.Redirect("AdminLogin.aspx");
            }
            else
            {
                Session.Abandon();
                Response.Redirect("AdminLogin.aspx");
            }
        }
    }
}