using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
namespace ECommerceBeeBox.Admin
{
    public partial class Report : System.Web.UI.Page
    {
        string connectionStirng = WebConfigurationManager.ConnectionStrings["connection"].ConnectionString.ToString();

        SqlConnection con;
        SqlCommand cmd;
        protected void Page_Load(object sender, EventArgs e)
        {
            con = new SqlConnection(connectionStirng);
            con.Open();

            if (!IsPostBack)
            {
                if (Session["AdminUser"] == null)
                {
                    Response.Redirect("LoginForm.aspx");
                }
                else
                {
                    //GetSellingReport(txtFromDate,txtToDate);
                }
            }
        }

        public void GetSellingReport(DateTime fromDate, DateTime toDate)
        {
            double grandtotal = 0;

            cmd = new SqlCommand("sp_SellingReport", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@FromDate", fromDate);
            cmd.Parameters.AddWithValue("@ToDate", toDate);

            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dataTable = new DataTable();
            sda.Fill(dataTable);
            if (dataTable.Rows.Count > 0)
            {
                foreach (DataRow DR in dataTable.Rows)
                {
                    grandtotal += Convert.ToDouble(DR["TotalPrice"]);
                }
            }
            lblTotal.Text = "Sold Cost: ₹" + grandtotal.ToString();
            lblTotal.CssClass = "badge badge-primary";

            rReport.DataSource = dataTable;
            rReport.DataBind();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            DateTime FromDate, ToDate;

            if (DateTime.TryParse(txtFromDate.Text, out FromDate) && DateTime.TryParse(txtToDate.Text, out ToDate))
            {
                if (ToDate > DateTime.Now)
                {
                    Response.Write("<script> alert(\"ToDate can't be greater than current Date!\"); </script>");
                }
                else if (FromDate > ToDate)
                {
                    Response.Write("<script> alert(\"FromDate can't be greater than ToDate!\"); </script>");
                }
                else
                {
                    GetSellingReport(FromDate, ToDate);
                }
            }
            else
            {
                Response.Write("<script> alert('Invalid date format!'); </script>");
            }


        }
    }
}