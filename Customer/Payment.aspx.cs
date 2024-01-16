using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data.SqlClient;
using System.Web.Configuration;
using System.Data;

using ECommerceBeeBox.Customer.Model;

namespace ECommerceBeeBox.Customer
{
    public partial class Payment : System.Web.UI.Page
    {
        string connectionString = WebConfigurationManager.ConnectionStrings["connection"].ConnectionString.ToString();

        DataTable dt;
        SqlTransaction transaction = null;
        SqlCommand cmd;
        SqlDataReader dr = null;


        string name = string.Empty, Address = string.Empty, PaymentMode = string.Empty, ExpiryDate = string.Empty;
        int cardNo = 0, cvvNo = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["CustomerId"] == null)
                {
                    Response.Redirect("Login.aspx");
                }
            }
        }

        protected void lbCardSubmit_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();

                name = txtName.Text.Trim();
                cardNo = Convert.ToInt32(txtCardNo.Text.Trim());
                cardNo = Convert.ToInt32(string.Format("************{0}", Convert.ToInt32(txtCardNo.Text.Trim().Substring(12, 4))));
                cvvNo = Convert.ToInt32(txtCvv.Text.Trim());
                Address = txtAddress.Text.Trim();
                PaymentMode = "Card";

                int month = Convert.ToInt32(txtExpMonth.Text.Trim());
                int year = Convert.ToInt32(txtExpYear.Text.Trim());

                // Validate the month and year (adjust these conditions based on your requirements)
                if (month >= 1 && month <= 12 && year >= DateTime.Now.Year)
                {
                    ExpiryDate = $"{month:D2}/{year % 100:D2}";
                }

                if (Session["CustomerId"] != null)
                {
                    OrderPayment(name, cardNo, ExpiryDate, cvvNo, Address, PaymentMode);
                }
                else
                {
                    Response.Redirect("Login.aspx");
                }
            }
        }

        protected void lbCodSubmit_Click(object sender, EventArgs e)
        {
            Address = txtCODAddress.Text.Trim();
            PaymentMode = "Cash On Delivery";

            if (Session["CustomerId"] != null)
            {
                OrderPayment(name, cardNo, ExpiryDate, cvvNo, Address, PaymentMode);
            }
            else
            {
                Response.Redirect("Login.aspx");
            }
        }

        public void OrderPayment(string Name, int CardNo, string ExpiryDate, int Cvv, string Address, string PaymentMode)
        {
            int paymentId, productId, Quantity;

            dt = new DataTable();
            dt.Columns.AddRange(new DataColumn[8] {

                new DataColumn("OrderNo", typeof(string)),
                new DataColumn("ProductId", typeof(int)),
                new DataColumn("Quantity", typeof(int)),
                new DataColumn("CustomerId", typeof(int)),
                new DataColumn("Status", typeof(string)),
                new DataColumn("PaymentId", typeof(int)),
                new DataColumn("OrderDate", typeof(DateTime)),
                new DataColumn("IsCancel", typeof(bool)),

            });

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();
                #region Sql Transaction
                transaction = con.BeginTransaction();

                cmd = new SqlCommand("sp_InsertPaymentData", con, transaction);

                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@Name", Name);
                cmd.Parameters.AddWithValue("@CardNo", CardNo);
                cmd.Parameters.AddWithValue("@ExpiryDate", ExpiryDate);
                cmd.Parameters.AddWithValue("@Cvv", Cvv);
                cmd.Parameters.AddWithValue("@Address", Address);
                cmd.Parameters.AddWithValue("@PaymentMode", PaymentMode);
                cmd.Parameters.Add("@InsertedId", SqlDbType.Int);
                cmd.Parameters["InsertedId"].Direction = ParameterDirection.Output;

                try
                {
                    cmd.ExecuteNonQuery();
                    paymentId = Convert.ToInt32(cmd.Parameters["InsertedId"].Value);

                    #region Getting Cart Item's
                    cmd = new SqlCommand("sp_DisplayCartItems", con, transaction);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@CustomerId", Session["CustomerId"]);
                    dr = cmd.ExecuteReader();

                    while (dr.Read())
                    {
                        productId = (int)dr["ProductId"];
                        Quantity = (int)dr["Quantity"];

                        //update Quantity to Product Table
                        PaymentOp.UpdateQuantity(productId, Quantity, transaction, con);
                        //update Quantity to Product Table End

                        //remove product cart table
                        PaymentOp.RemoveProductFromCart(productId, Convert.ToInt32(Session["CustomerId"]), transaction, con);
                        //remove product cart table End

                        dt.Rows.Add(CartCrud.GetUniqueId(), productId, Quantity, (int)Session["CustomerId"], "Pending", paymentId, Convert.ToDateTime(DateTime.Now)
                            , true);
                    }
                    dr.Close();

                    #endregion Getting Cart Item's

                    #region Order Details
                    if (dt.Rows.Count > 0)
                    {
                        cmd = new SqlCommand("sp_InsertOrderDetails", con, transaction);
                        cmd = new SqlCommand("sp_InsertOrderData", con, transaction);
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@tblOrders", dt);
                        cmd.ExecuteNonQuery();
                    }
                    #endregion Order Details

                    transaction.Commit();

                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "Ordered('" + paymentId + "');", true);

                    //Response.AddHeader("REFRESH", "1;URL=Invoice.aspx?pid" + paymentId);

                }
                catch (Exception ex)
                {
                    try
                    {
                        transaction.Rollback();

                    }
                    catch (Exception e)
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "alert", "ExceptionError('" + e.Message + "');", true);
                    }
                }
                #endregion Sql Transaction
            }
        }
    }
}