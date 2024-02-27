using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Security.Principal;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace ECommerceBeeBox.Customer
{
    public partial class MyProfile : System.Web.UI.Page
    {
        string ConnectionString = WebConfigurationManager.ConnectionStrings["connection"].ConnectionString.ToString();

        SqlConnection con;
        protected void Page_Load(object sender, EventArgs e)
        {
            con = new SqlConnection(ConnectionString);
            con.Open();

            if (Session["CustomerId"] == null)
            {
                Response.Redirect("Login.aspx");
            }

            if (!IsPostBack)
            {
                GetCustomerProfile();
                GetCustomerData();
                GetPurchasedHistory();
            }
        }

        public void GetCustomerProfile()
        {
            using (SqlCommand cmd = new SqlCommand("select * from Customer where CustomerId='" + Session["CustomerId"] + "' and IsActive=1 ", con))
            {
                using (SqlDataReader drProfile = cmd.ExecuteReader())
                {
                    if (drProfile.Read())
                    {
                        imgProfile.ImageUrl = drProfile["ImageUrl"].ToString();

                        Session["CustomerUser"] = drProfile["Name"].ToString();
                        lblCreateDate.Text = drProfile["CreateDate"].ToString();
                        //lblAddress.Text = drProfile["Address"].ToString();
                        lblEmail.Text = drProfile["Email"].ToString();
                        lblMobile.Text = drProfile["Mobile"].ToString();
                        //lblPostCode.Text = drProfile["PostCode"].ToString();

                    }

                    rCustomerBasicInfo.DataSource = drProfile;
                    rCustomerBasicInfo.DataBind();
                }
            }
        }

        public void GetCustomerData()
        {
            using (SqlCommand cmd = new SqlCommand("select * from Customer where CustomerId='" + Session["CustomerId"] + "' and IsActive=1 ", con))
            {
                using (SqlDataReader drProfile = cmd.ExecuteReader())
                {
                    rCustomerBasicInfo.DataSource = drProfile;
                    rCustomerBasicInfo.DataBind();
                }
            }
        }

        public void GetPurchasedHistory()
        {
            int sessionId = Convert.ToInt32(Session["CustomerId"]);
            int srno = 1;

            using (SqlCommand cmd = new SqlCommand("sp_OrderHistory", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@CustomerId", sessionId);

                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    DataTable dtOrderHistory = new DataTable();
                    da.Fill(dtOrderHistory);

                    dtOrderHistory.Columns.Add("#", typeof(Int32));
                    if (dtOrderHistory.Rows.Count > 0)
                    {
                        foreach (DataRow loop in dtOrderHistory.Rows)
                        {
                            loop["#"] = srno;
                            srno++;

                        }

                    }
                    if (dtOrderHistory.Rows.Count > 0)
                    {
                        rPurchasedHistory.DataSource = dtOrderHistory;
                        rPurchasedHistory.DataBind();
                    }
                    else
                    {
                        rPurchasedHistory.Visible = false;
                        lblOrder.Visible = true;
                    }
                }
            }

        }

        protected void lbtnEditDetails_Click(object sender, EventArgs e)
        {
            //using (SqlConnection con = new SqlConnection(ConnectionString))
            //{
            //    con.Open();

            //    using (SqlCommand cmd = new SqlCommand("select CustomerId from Customer where CustomerId=@CustomerId", con))
            //    {
            //        cmd.Parameters.AddWithValue("@CustomerId", Session["CustomerId"]);

            //        using (SqlDataReader reader = cmd.ExecuteReader())
            //        {
            //            if (reader.Read())
            //            {
            //                int id = Convert.ToInt32(reader["CustomerId"]);

            //                Response.Redirect("UpdateCustomer.aspx?id='" + id + "' ");

            //            }
            //        }
            //    }
            //}

            //Response.Redirect("UpdateCustomer.aspx?id='" + Session["CustomerId"] + "' ");

            Response.Redirect("UpdateCustomer.aspx");

        }

        protected void lbtnUpdatePassword_Click(object sender, EventArgs e)
        {
            Response.Redirect("ChangePassword.aspx");
        }

        protected void rPurchasedHistory_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            int sessionId = Convert.ToInt32(Session["CustomerId"]);
            double TotalAmount = 0;

            HiddenField paymentId = e.Item.FindControl("hfPaymentId") as HiddenField;
            Repeater repeaterOrders = e.Item.FindControl("rOrderDetails") as Repeater;

            using (SqlCommand cmd = new SqlCommand("sp_Invoice", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@CustomerId", sessionId);
                cmd.Parameters.AddWithValue("@PaymentId", Convert.ToInt32(paymentId.Value));

                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    DataTable dtOrder = new DataTable();
                    da.Fill(dtOrder);
                    if (dtOrder.Rows.Count > 0)
                    { 

                        foreach (DataRow loop in dtOrder.Rows)
                        {
                            TotalAmount += Convert.ToDouble(loop["TotalAmount"]);
                        }
                    }

                    //DataRow dataRow = dtOrder.NewRow();
                    //dataRow["TotalAmount"] = TotalAmount;
                    //dtOrder.Rows.Add(dataRow);

                    Session["Prices"] = TotalAmount;

                    repeaterOrders.DataSource = dtOrder;
                    repeaterOrders.DataBind();
                }
            }
        }
        protected void rOrderDetails_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "cancel")
            {
                Response.Redirect("CancelOrder.aspx?id=" + e.CommandArgument);
            }
        }

        protected void rOrderDetails_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                LinkButton lbtnCancel = e.Item.FindControl("lbtnCancel") as LinkButton;
                Label lblStatus = e.Item.FindControl("lblStatus") as Label;

                if (lblStatus != null && lbtnCancel != null)
                {
                    if (lblStatus.Text.Trim() == "Delivered")
                    {
                        lbtnCancel.Visible = false;
                    }
                    else
                    {
                        lbtnCancel.Visible = true;
                    }
                }
            }
        }
    }
}