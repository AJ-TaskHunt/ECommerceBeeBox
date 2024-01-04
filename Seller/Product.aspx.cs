using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Configuration;

namespace ECommerceBeeBox.Seller
{
    public partial class Product : System.Web.UI.Page
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

                GetProductData();
                BindCategoryDropDown();
                BindSubCategoryDropDown(ddlCategory.SelectedValue);

            }

            btnUpdate.Visible = false;
            btnClear.Text = "Reset";
            imgProfile.Visible = true;
            lblmsg.Visible = false;
            lblCategory.Visible = false;
            lblSubCategory.Visible = false;
        }

        public void GetProductData()
        {
            cmd = new SqlCommand("select p.*, cat.CategoryName , Sub.SubCategoryName from Product p join  Category cat on cat.CategoryId = p.CategoryId join SubCategory sub on sub.SubCategoryId = p.SubCategoryId where cat.IsActive=1 and sub.IsActive=1", con);

            SqlDataReader dr = cmd.ExecuteReader();

            rProductData.DataSource = dr;
            rProductData.DataBind();
            dr.Close();
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            if (fuProductImage.HasFiles)
            {
                string imgName = Path.GetFileName(fuProductImage.FileName);
                fuProductImage.SaveAs(Server.MapPath("~/SellerTemplate/ProductImage/" + fuProductImage.FileName));

                cmd = new SqlCommand("sp_InsertProductBySeller", con);
                cmd.CommandType = CommandType.StoredProcedure;


                cmd.Parameters.AddWithValue("@ProductName", txtProductName.Text);
                cmd.Parameters.AddWithValue("@Description", txtProductDescription.Text);
                cmd.Parameters.AddWithValue("@Price", txtProductPrice.Text);
                cmd.Parameters.AddWithValue("@Quantity", txtProductQuantity.Text);
                cmd.Parameters.AddWithValue("@ProductImage", imgName);
                cmd.Parameters.AddWithValue("@CategoryId", ddlCategory.SelectedValue);
                cmd.Parameters.AddWithValue("@SubCategoryId", ddlSubCategory.SelectedValue);
                cmd.Parameters.AddWithValue("@IsActive", cbIsActive.Checked);
                cmd.Parameters.AddWithValue("@SellerId", Session["SellerId"]);

                int InsertProdcutData = cmd.ExecuteNonQuery();

                if (InsertProdcutData > 0)
                {
                    lblmsg.Visible = true;
                    lblmsg.Text = "Product Added SuccesFully!";
                    lblmsg.CssClass = "alert alert-success";

                    GetProductData();

                    txtProductName.Text = "";
                    txtProductDescription.Text = "";
                    txtProductPrice.Text = "";
                    txtProductQuantity.Text = "";
                    ddlCategory.SelectedIndex = 0;
                    ddlSubCategory.SelectedIndex = 0;

                    cbIsActive.Checked = false;
                }

            }
            else
            {
                lblmsg.Visible = true;
                lblmsg.Text = "Please Select Image File";
                lblmsg.CssClass = "alert alert-danger";
            }


        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            HttpPostedFile imgName = fuProductImage.PostedFile;

            if (imgName != null && imgName.ContentLength > 0)
            {
                string fileName = Path.GetFileName(fuProductImage.FileName);
                string uploadFolderPath = Server.MapPath("~/SellerTemplate/ProductImage/");
                string filePath = Path.Combine(uploadFolderPath, fileName);
                fuProductImage.SaveAs(filePath);

                using (SqlConnection con = new SqlConnection(ConnectionString))
                {
                    con.Open();

                    using (SqlCommand cmd = new SqlCommand("sp_UpdateProductData", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;

                        // Check if image needs to be updated
                        string updateImage = "YES";
                        cmd.Parameters.AddWithValue("@UpdateImage", updateImage);

                        cmd.Parameters.AddWithValue("@ProductId", hfProductId.Value);
                        cmd.Parameters.AddWithValue("@ProductName", txtProductName.Text);
                        cmd.Parameters.AddWithValue("@Description", txtProductDescription.Text);
                        cmd.Parameters.AddWithValue("@Price", txtProductPrice.Text); // Corrected parameter name
                        cmd.Parameters.AddWithValue("@Quantity", txtProductQuantity.Text);
                        cmd.Parameters.AddWithValue("@CategoryId", ddlCategory.SelectedValue);
                        cmd.Parameters.AddWithValue("@SubCategoryId", ddlSubCategory.SelectedValue);
                        cmd.Parameters.AddWithValue("@IsActive", cbIsActive.Checked);
                        cmd.Parameters.AddWithValue("@ProductImage", fileName);

                        cmd.ExecuteNonQuery();

                        txtProductName.Text = "";
                        txtProductDescription.Text = "";
                        txtProductPrice.Text = "";
                        txtProductQuantity.Text = "";
                        ddlCategory.SelectedIndex = 0;
                        ddlSubCategory.SelectedIndex = 0;
                        imgProfile.Visible = false;
                        cbIsActive.Checked = false;
                        btnAdd.Visible = true;

                        GetProductData();
                    }
                }
            }
            else
            {
                using (SqlConnection con = new SqlConnection(ConnectionString))
                {
                    con.Open();

                    using (SqlCommand cmd = new SqlCommand("sp_UpdateProductData", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;

                        // Check if image needs to be updated
                        string updateImage = "NO";
                        cmd.Parameters.AddWithValue("@UpdateImage", updateImage);

                        cmd.Parameters.AddWithValue("@ProductId", hfProductId.Value);
                        cmd.Parameters.AddWithValue("@ProductName", txtProductName.Text);
                        cmd.Parameters.AddWithValue("@Description", txtProductDescription.Text);
                        cmd.Parameters.AddWithValue("@Price", txtProductPrice.Text); // Corrected parameter name
                        cmd.Parameters.AddWithValue("@Quantity", txtProductQuantity.Text);
                        cmd.Parameters.AddWithValue("@CategoryId", ddlCategory.SelectedValue);
                        cmd.Parameters.AddWithValue("@SubCategoryId", ddlSubCategory.SelectedValue);
                        cmd.Parameters.AddWithValue("@IsActive", cbIsActive.Checked);
                        cmd.Parameters.AddWithValue("@ProductImage", DBNull.Value);


                        cmd.ExecuteNonQuery();

                        txtProductName.Text = "";
                        txtProductDescription.Text = "";
                        txtProductPrice.Text = "";
                        txtProductQuantity.Text = "";
                        ddlCategory.SelectedIndex = 0;
                        ddlSubCategory.SelectedIndex = 0;
                        imgProfile.Visible = false;
                        cbIsActive.Checked = false;
                        btnAdd.Visible = true;

                        GetProductData();
                    }
                }
            }

            lblmsg.Visible = true;
            lblmsg.Text = "Product updated successfully!";
            lblmsg.CssClass = "alert alert-success";


        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            txtProductName.Text = "";
            txtProductDescription.Text = "";
            txtProductPrice.Text = "";
            txtProductQuantity.Text = "";
            ddlCategory.SelectedIndex = 0;
            ddlSubCategory.SelectedIndex = 0;
            imgProfile.Visible = false;
            cbIsActive.Checked = false;

            btnAdd.Visible = true;


        }

        protected void rCategoryData_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "edit")
            {
                cmd = new SqlCommand("select p.*, sub.*, cat.* from Product p join SubCategory sub on p.SubCategoryId = sub.SubCategoryId  join Category cat on p.CategoryId = cat.CategoryId where p.ProductId='" + e.CommandArgument + "'", con);

                //cmd = new SqlCommand("select * from Product where ProductId='" + e.CommandArgument + "' ", con);

                SqlDataReader drUpdateProductData = cmd.ExecuteReader();

                if (drUpdateProductData.Read())
                {
                    txtProductName.Text = drUpdateProductData["ProductName"].ToString();
                    imgProfile.ImageUrl = "~/SellerTemplate/ProductImage/" + drUpdateProductData["ProductImageUrl"].ToString();
                    txtProductDescription.Text = drUpdateProductData["Description"].ToString();
                    txtProductPrice.Text = drUpdateProductData["Price"].ToString();
                    txtProductQuantity.Text = drUpdateProductData["Quantity"].ToString();
                    ddlCategory.SelectedValue = drUpdateProductData["CategoryId"].ToString();
                    string selectedSubcategoryId = drUpdateProductData["SubCategoryId"].ToString();
                    bool isActive = Convert.ToBoolean(drUpdateProductData["IsActive"]);
                    drUpdateProductData.Close();

                    using (SqlCommand subCategoryCmd = new SqlCommand("SELECT SubCategoryId, SubCategoryName FROM SubCategory WHERE CategoryId = @CategoryId", con))
                    {
                        subCategoryCmd.Parameters.AddWithValue("@CategoryId", ddlCategory.SelectedValue);

                        SqlDataReader drSubCategory = subCategoryCmd.ExecuteReader();

                        ddlSubCategory.DataSource = drSubCategory;
                        ddlSubCategory.DataTextField = "SubCategoryName";
                        ddlSubCategory.DataValueField = "SubCategoryId";
                        ddlSubCategory.DataBind();
                        ddlSubCategory.Items.Insert(0, new ListItem("Select Subcategory", "0"));

                        drSubCategory.Close();
                    }



                    if (ddlSubCategory.Items.FindByValue(selectedSubcategoryId) != null)
                    {
                        ddlSubCategory.SelectedValue = selectedSubcategoryId;
                    }
                    //  drUpdateProductData = cmd.ExecuteReader();

                    cbIsActive.Checked = isActive;
                    hfProductId.Value = e.CommandArgument.ToString();

                }
                drUpdateProductData.Close();
                btnAdd.Visible = false;
                btnUpdate.Visible = true;
                btnClear.Text = "Cancel";

                lblCategory.Visible = true;
                lblSubCategory.Visible = true;
            }


        }
        private void BindCategoryDropDown()
        {

            cmd = new SqlCommand("SELECT * FROM Category WHERE IsActive=1", con);

            using (SqlDataReader drCategory = cmd.ExecuteReader())
            {
                ddlCategory.DataSource = drCategory;
                ddlCategory.DataTextField = "CategoryName";
                ddlCategory.DataValueField = "CategoryId";
                ddlCategory.DataBind();
                ddlCategory.Items.Insert(0, new ListItem("Select Category", "0"));
                drCategory.Close();
            }

        }
        private void BindSubCategoryDropDown(string categoryId)
        {
            cmd = new SqlCommand("SELECT sub.*, cat.CategoryName as CategoryName FROM SubCategory sub INNER JOIN Category cat ON cat.CategoryId = sub.CategoryId WHERE cat.IsActive=1 AND sub.CategoryId = @CategoryId ORDER BY sub.CreateDate DESC", con);

            cmd.Parameters.AddWithValue("@CategoryId", categoryId);

            using (SqlDataReader drDisplaySubCategoryData = cmd.ExecuteReader())
            {
                ddlSubCategory.DataSource = drDisplaySubCategoryData;
                ddlSubCategory.DataTextField = "SubCategoryName";
                ddlSubCategory.DataValueField = "SubCategoryId";
                ddlSubCategory.DataBind();
                ddlSubCategory.Items.Insert(0, new ListItem("Select Subcategory", "0"));
                drDisplaySubCategoryData.Close();
            }
        }

        protected void ddlCategory_SelectedIndexChanged(object sender, EventArgs e)
        {

            BindSubCategoryDropDown(ddlCategory.SelectedValue);

        }

    }
}