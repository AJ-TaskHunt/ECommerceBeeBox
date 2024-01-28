using ECommerceBeeBox.Admin.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using static ECommerceBeeBox.Admin.Model.DashboardCount;

namespace ECommerceBeeBox.Admin
{
    public partial class Dashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                if (Session["AdminUser"] == null)
                {
                    Response.Redirect("AdminLogin.aspx");
                }
                else
                {
                    DashboardCount db = new DashboardCount();

                    Session["Customer"] = db.Count("CUSTOMER");
                    Session["Blocked_Customer"] = db.Count("BLOCKED_CUSTOMER");
                    Session["Product"] = db.Count("PRODUCT");
                    Session["Category"] = db.Count("CATEGORY");
                    Session["SubCategory"] = db.Count("SUBCATEGORY");
                }

            }
        }




    }
}