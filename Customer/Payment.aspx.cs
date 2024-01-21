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
        SqlDataReader dr, dr2;
        SqlConnection con;

        PaymentOp paymentTransction = new PaymentOp();

        string name = string.Empty, Address = string.Empty, PaymentMode = string.Empty, ExpiryDate = string.Empty;
        long cardNo = 0, cvvNo = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            con = new SqlConnection(connectionString);
            con.Open();

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

        protected void lbCodSubmit_Click(object sender, EventArgs e)
        {
            Address = txtCODAddress.Text.Trim();
            PaymentMode = "Cash On Delivery";

            name = "None";
            ExpiryDate = "None";            

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
                    UpdateQuantity(productId, Quantity);
                    //update Quantity to Product Table End

                    //remove product cart table
                    RemoveProductFromCart(productId, Convert.ToInt32(Session["CustomerId"]), con);
                    //remove product cart table End

                    OrderData(productId, Quantity, Convert.ToInt32(Session["CustomerId"]), paymentId, con);
                    //}
                }
                dr.Close();

                //Response.AddHeader("REFRESH", "1;URL=Invoice.aspx?pid=" + paymentId);

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

        public void UpdateQuantity(int productId, int qty)
        {
            int DBQuantity;

            using (SqlConnection conProductUpdate = new SqlConnection(connectionString))
            {
                conProductUpdate.Open();
                SqlCommand cmdUpdateProduct = new SqlCommand("select * from Product where ProductId=@ProductId", conProductUpdate);

                cmdUpdateProduct.Parameters.AddWithValue("@ProductId", productId);

                try
                {
                    dr2 = cmdUpdateProduct.ExecuteReader();

                    while (dr2.Read())
                    {
                        DBQuantity = (int)dr2["Quantity"];

                        if (DBQuantity > qty && DBQuantity > 2)
                        {
                            DBQuantity = DBQuantity - qty;

                            cmdUpdateProduct = new SqlCommand("update Product set Quantity=@Quantity where ProductId=@ProductId", conProductUpdate);
                            cmdUpdateProduct.Parameters.AddWithValue("@ProductId", productId);
                            cmdUpdateProduct.Parameters.AddWithValue("@Quantity", DBQuantity);

                            cmdUpdateProduct.ExecuteNonQuery();
                        }
                    }
                    dr2.Close();
                }
                catch (Exception)
                {

                }
                finally
                {
                    conProductUpdate.Close();
                }

            }

        }

        public void RemoveProductFromCart(int productId, int sessionId, SqlConnection sqlConnection)
        {
            SqlCommand cmdRemoveProduct = new SqlCommand("sp_DeleteCartItem", sqlConnection);
            cmdRemoveProduct.CommandType = CommandType.StoredProcedure;

            cmdRemoveProduct.Parameters.AddWithValue("@ProductId", productId);
            cmdRemoveProduct.Parameters.AddWithValue("@CustomerId", sessionId);

            cmdRemoveProduct.ExecuteNonQuery();

        }

        public void OrderData(int productId, int Quantity, int sessionId, int paymentId, SqlConnection sqlConnection)
        {

            SqlCommand cmdOrderData = new SqlCommand("sp_InsertOrderData", sqlConnection);
            cmdOrderData.CommandType = CommandType.StoredProcedure;

            cmdOrderData.Parameters.AddWithValue("@OrderNo", CartCrud.GetUniqueId());
            cmdOrderData.Parameters.AddWithValue("@PaymentId", paymentId);
            cmdOrderData.Parameters.AddWithValue("@CustomerId", sessionId);
            cmdOrderData.Parameters.AddWithValue("@ProductId", productId);
            cmdOrderData.Parameters.AddWithValue("@Quantity", Quantity);
            cmdOrderData.Parameters.AddWithValue("@Status", "Pending");

            cmdOrderData.ExecuteNonQuery();

            ClientScript.RegisterStartupScript(this.GetType(), "alert", "Ordered('" + paymentId + "');", true);

        }
    }
}