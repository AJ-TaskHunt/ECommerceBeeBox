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

        SqlCommand cmd;
        SqlDataReader dr;

        PaymentOp paymentTransction = new PaymentOp();

        string name = string.Empty, Address = string.Empty, PaymentMode = string.Empty, ExpiryDate = string.Empty;
        long cardNo = 0, cvvNo = 0;
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
            name = txtName.Text.Trim();
            cardNo = Convert.ToInt64(txtCardNo.Text);
            cvvNo = Convert.ToInt64(txtCvv.Text.Trim());
            Address = txtAddress.Text.Trim();
            PaymentMode = "Card";
            int month = Convert.ToInt32(txtExpMonth.Text.Trim());
            int year = Convert.ToInt32(txtExpYear.Text.Trim());
            //cardNo = Convert.ToInt64(string.Format("************{0}", Convert.ToInt64(txtCardNo.Text.Trim().Substring(12, 4))));

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();

                if (long.TryParse(txtCardNo.Text.Trim().Substring(12, 4), out cardNo))
                {
                    string formattedCardNo = string.Format("************{0}", cardNo);

                    if (month >= 1 && month <= 12)
                    {
                        ExpiryDate = month + "/" + year;

                        if (Session["CustomerId"] != null)
                        {
                            OrderPayment(name, cardNo, ExpiryDate, cvvNo, Address, PaymentMode);
                        }
                        else
                        {
                            Response.Redirect("Login.aspx");
                        }
                    }
                    else
                    {
                        lblMsg.Visible = true;
                        lblMsg.Text = "Invalid Moths or Year";
                        lblMsg.CssClass = "alert alert-danger";
                    }
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

        public void OrderPayment(string Name, long CardNo, string ExpiryDate, long Cvv, string Address, string PaymentMode)
        {
            int paymentId, productId, Quantity;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();
                cmd = new SqlCommand("sp_InsertPaymentData", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@Name", Name);
                cmd.Parameters.AddWithValue("@CardNo", CardNo);
                cmd.Parameters.AddWithValue("@ExpiryDate", ExpiryDate);
                cmd.Parameters.AddWithValue("@Cvv", Cvv);
                cmd.Parameters.AddWithValue("@Address", Address);
                cmd.Parameters.AddWithValue("@PaymentMode", PaymentMode);
                cmd.Parameters.Add("@InsertedId", SqlDbType.Int);
                cmd.Parameters["@InsertedId"].Direction = ParameterDirection.Output;

                try
                {
                    cmd.ExecuteNonQuery();
                    paymentId = Convert.ToInt32(cmd.Parameters["@InsertedId"].Value);

                    if (dr != null && !dr.IsClosed)
                        dr.Close();

                    cmd = new SqlCommand("sp_DisplayCartItems", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@CustomerId", Session["CustomerId"]);
                    dr = cmd.ExecuteReader();

                    while (dr.Read())
                    {
                        productId = (int)dr["ProductId"];
                        Quantity = (int)dr["Quantity"];

                        // ViewState["productId"] = productId;
                        //ViewState["Quantity"] = Quantity;                       

                        //using (SqlConnection conUpdate = new SqlConnection(connectionString))
                        //{
                            //update Quantity to Product Table
                            paymentTransction.UpdateQuantity(productId, Quantity, con);
                            //update Quantity to Product Table End

                            //remove product cart table
                            paymentTransction.RemoveProductFromCart(productId, Convert.ToInt32(Session["CustomerId"]), con);
                            //remove product cart table End

                            paymentTransction.OrderData(productId, Quantity, (int)Session["CustometId"], paymentId, con);
                        //}
                    }
                    dr.Close();

                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "Ordered('" + paymentId + "');", true);

                    //Response.AddHeader("REFRESH", "1;URL=Invoice.aspx?pid" + paymentId);

                }
                catch (Exception e)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "ExceptionError('" + e.Message + "');", true);
                }
                finally
                {
                    con.Close();
                }
            }
        }


        //void UpdateQuantity(int productId, int qty, SqlTransaction transaction, SqlConnection sqlConnection)
        //{
        //    // Create a DataTable to hold the results
        //    DataTable productTable = new DataTable();

        //    using (SqlCommand selectCmd = new SqlCommand("SELECT * FROM Product WHERE ProductId = @ProductId", sqlConnection, transaction))
        //    {
        //        selectCmd.Parameters.AddWithValue("@ProductId", productId);

        //        try
        //        {
        //            using (SqlDataAdapter adapter = new SqlDataAdapter(selectCmd))
        //            {
        //                // Fill the DataTable with the results of the SELECT query
        //                adapter.Fill(productTable);
        //            }

        //            // Check if there are rows in the DataTable
        //            if (productTable.Rows.Count > 0)
        //            {
        //                DataRow row = productTable.Rows[0];
        //                int dbQuantity = (int)row["Quantity"];

        //                if (dbQuantity > qty && dbQuantity > 2)
        //                {
        //                    // Update the quantity in-memory
        //                    row["Quantity"] = dbQuantity - qty;

        //                    // Create a new SqlCommand for the update operation
        //                    using (SqlCommand updateCmd = new SqlCommand("UPDATE Product SET Quantity = @Quantity WHERE ProductId = @ProductId", sqlConnection, transaction))
        //                    {
        //                        updateCmd.Parameters.AddWithValue("@Quantity", row["Quantity"]);
        //                        updateCmd.Parameters.AddWithValue("@ProductId", productId);
        //                        updateCmd.ExecuteNonQuery();
        //                    }
        //                }
        //            }
        //        }
        //        catch (Exception exp)
        //        {
        //            // Handle the exception (log or rethrow if necessary)
        //        }
        //    }
        //}

    }
}