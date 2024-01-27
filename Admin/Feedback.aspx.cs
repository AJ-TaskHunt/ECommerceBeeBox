using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data.SqlClient;
using System.Data;
using System.Web.Configuration;

namespace ECommerceBeeBox.Admin
{
    public partial class Feedback : System.Web.UI.Page
    {
        string ConnectionString = WebConfigurationManager.ConnectionStrings["connection"].ConnectionString.ToString();

        SqlConnection con;
        SqlCommand cmd;
        protected void Page_Load(object sender, EventArgs e)
        {
            con = new SqlConnection(ConnectionString);
            con.Open();

            if (!IsPostBack)
            {
                if (Session["AdminUser"] != null)
                {
                    getFeedback();
                }
                else
                {
                    Response.Redirect("AdminLogin.aspx");
                }
            }
        }

        public void getFeedback()
        {
            cmd = new SqlCommand("sp_DisplayFeedback", con);
            cmd.CommandType = CommandType.StoredProcedure;

            SqlDataReader dataReader = cmd.ExecuteReader();

            rFeedback.DataSource = dataReader;
            rFeedback.DataBind();
        }

        protected void rFeedback_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "delete")
            {
                cmd = new SqlCommand("delete from Contact where ContactId = @ContactId", con);
                cmd.Parameters.AddWithValue("@ContactId", e.CommandArgument);

                cmd.ExecuteNonQuery();

                lblmsg.Visible = true;
                lblmsg.Text = "Feedback deleted successfully!";
                lblmsg.CssClass = "alert alert-success";

                getFeedback();
            }
        }
    }
}