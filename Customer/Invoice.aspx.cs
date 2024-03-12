using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data.SqlClient;
using System.Web.Configuration;
using System.Data;
using System.Drawing.Printing;
using System.Xml.Linq;
using iTextSharp.text.pdf;
using iTextSharp.text;
using System.Net;
using System.IO;


namespace ECommerceBeeBox.Customer
{
    public partial class Invoice : System.Web.UI.Page
    {
        string connectionString = WebConfigurationManager.ConnectionStrings["connection"].ConnectionString.ToString();

        SqlConnection con;
        SqlCommand cmd;
        SqlDataReader dr;
        DataTable dt;
        SqlDataAdapter sda;
        protected void Page_Load(object sender, EventArgs e)
        {
            con = new SqlConnection(connectionString);
            con.Open();

            if (!IsPostBack)
            {
                if (Session["CustomerId"] != null)
                {
                    if (Request.QueryString["pid"] != null)
                    {
                        rOrderDetails.DataSource = GetOrderDetails();
                        rOrderDetails.DataBind();
                    }
                }
                else
                {
                    Response.Redirect("Login.aspx");
                }
            }
        }

        private DataTable GetOrderDetails()
        {
            double TotalAmount = 0;

            int PaymentId = Convert.ToInt32(Request.QueryString["pid"]);
            int CustomerId = Convert.ToInt32(Session["CustomerId"]);

            cmd = new SqlCommand("sp_Invoice", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.AddWithValue("@PaymentId", PaymentId);
            cmd.Parameters.AddWithValue("@CustomerId", CustomerId);

            sda = new SqlDataAdapter(cmd);
            dt = new DataTable();   
            sda.Fill(dt);

            if (dt.Rows.Count > 0)
            {
                foreach (DataRow totalprice in dt.Rows)
                {
                    TotalAmount += Convert.ToDouble(totalprice["TotalAmount"]);
                }
            }

            DataRow dr = dt.NewRow();
            dr["TotalAmount"] = TotalAmount;
            dt.Rows.Add(dr);

            return dt;
        }

        protected void lbtnDownloadInvoice_Click(object sender, EventArgs e)
        {
            try
            {
                string downloadPath = @"D:\order_Invoice.pdf";

                DataTable dataTable = GetOrderDetails();
                ExportToPdf(dataTable, downloadPath, "Your Order Invoice");

                WebClient wc = new WebClient();
                Byte[] buffer = wc.DownloadData(downloadPath);

                if (buffer != null)
                {
                    Response.ContentType = "application/pdf";
                    Response.AddHeader("content-length", buffer.Length.ToString());
                    Response.BinaryWrite(buffer);
                }

            }
            catch (Exception ex)
            {
                lblmsg.Visible = true;
                lblmsg.Text = "Error " + ex.Message.ToString();

            }
        }

        void ExportToPdf(DataTable dtblTable, String strPdfPath, string strHeader)
        {
            // Define your manual table header names
            List<string> manualHeaderNames = new List<string>
            {
                "#",
                "Order No",
                "Product Name",
                "Price",
                "Quantity",
                "Total Price"
                // Add more headers as needed
            };

            FileStream fs = new FileStream(strPdfPath, FileMode.Create, FileAccess.Write, FileShare.None);
            Document document = new Document();
            document.SetPageSize(PageSize.A4);
            PdfWriter writer = PdfWriter.GetInstance(document, fs);

            document.Open();

            // Report Header
            BaseFont bfntHead = BaseFont.CreateFont(BaseFont.TIMES_ROMAN, BaseFont.CP1252, BaseFont.NOT_EMBEDDED);
            Font fntHead = new Font(bfntHead, 18, Font.BOLD, Color.ORANGE); // Increased font size and added bold
            Paragraph prgHeading = new Paragraph(strHeader.ToUpper(), fntHead);
            prgHeading.Alignment = Element.ALIGN_CENTER;
            document.Add(prgHeading);

            // Author
            Paragraph prgAuthor = new Paragraph();
            BaseFont btnAuthor = BaseFont.CreateFont(BaseFont.TIMES_ROMAN, BaseFont.CP1252, BaseFont.NOT_EMBEDDED);
            Font fntAuthor = new Font(btnAuthor, 12, Font.NORMAL, Color.BLACK); // Adjusted font size and style
            prgAuthor.Alignment = Element.ALIGN_RIGHT;
            prgAuthor.Add(new Chunk("Order From : BeeBox", fntAuthor));
            prgAuthor.Add(new Chunk("\nOrder Date : " + dtblTable.Rows[0]["OrderDate"].ToString(), fntAuthor));
            document.Add(prgAuthor);

            // Add a line separation
            document.Add(new Chunk("\n", fntHead));

            // Write the table
            PdfPTable table = new PdfPTable(dtblTable.Columns.Count - 2);
            table.WidthPercentage = 100;

            // Manual Table header
            BaseFont btnColumnHeader = BaseFont.CreateFont(BaseFont.TIMES_ROMAN, BaseFont.CP1252, BaseFont.NOT_EMBEDDED);
            Font fntColumnHeader = new Font(btnColumnHeader, 13, Font.BOLD, Color.WHITE); // Adjusted font size and added bold
            foreach (var headerName in manualHeaderNames)
            {
                PdfPCell cell = new PdfPCell();
                cell.BackgroundColor = Color.GRAY;
                cell.Padding = 8;
                cell.AddElement(new Chunk(headerName.ToUpper(), fntColumnHeader));
                table.AddCell(cell);
            }

            //// Table header
            //BaseFont btnColumnHeader = BaseFont.CreateFont(BaseFont.TIMES_ROMAN, BaseFont.CP1252, BaseFont.NOT_EMBEDDED);
            //Font fntColumnHeader = new Font(btnColumnHeader, 10, Font.BOLD, Color.WHITE); // Adjusted font size and added bold
            //for (int i = 0; i < dtblTable.Columns.Count - 2; i++)
            //{
            //    PdfPCell cell = new PdfPCell();
            //    cell.BackgroundColor = Color.GRAY;
            //    cell.Padding = 8;
            //    cell.AddElement(new Chunk(dtblTable.Columns[i].ColumnName.ToUpper(), fntColumnHeader));
            //    table.AddCell(cell);
            //}

            // Table Data
            Font fntColumnData = new Font(btnColumnHeader, 10, Font.NORMAL, Color.BLACK); // Adjusted font size and style
            for (int i = 0; i < dtblTable.Rows.Count; i++)
            {
                for (int j = 0; j < dtblTable.Columns.Count - 2; j++)
                {
                    PdfPCell cell = new PdfPCell();
                    cell.Padding = 8;
                    cell.AddElement(new Chunk(dtblTable.Rows[i][j].ToString(), fntColumnData));
                    table.AddCell(cell);
                }
            }

            document.Add(table);
            document.Close();
            writer.Close();
        }

    }
}