﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data.SqlClient;
using System.Data;
using System.Web.Configuration;
using System.Diagnostics.Eventing.Reader;

namespace ECommerceBeeBox.Admin
{
    public partial class Category : System.Web.UI.Page
    {
        string connectionString = WebConfigurationManager.ConnectionStrings["Connection"].ConnectionString.ToString();

        SqlConnection con;
        SqlCommand cmd;
        protected void Page_Load(object sender, EventArgs e)
        {
            con = new SqlConnection(connectionString);
            con.Open();

            if (Session["AdminUser"] == null)
            {
                Response.Redirect("AdminLogin.aspx");
            }

            if (!IsPostBack)
            {
                GetCategoryData();
            }

            btnUpdate.Visible = false;
            lblmsg.Visible = false;

            btnClear.Text = "Reset";

        }

        protected void btnAddCategoryData_Click(object sender, EventArgs e)
        {
            cmd = new SqlCommand("sp_CheckCategorySpecificData", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.AddWithValue("@CategoryName", txtCategoryname.Text.Trim());

            SqlDataReader drCheckCategoryData = cmd.ExecuteReader();

            if (drCheckCategoryData.Read())
            {
                lblmsg.Visible = true;

                lblmsg.Text = "Category All ready exists";
                lblmsg.CssClass = "alert alert-primary";

                txtCategoryname.Text = "";
                txtCategoryname.Focus();

                cbIsActive.Checked = false;
            }
            else
            {
                drCheckCategoryData.Close();

                if (fuCatgeoryImage.HasFile)
                {
                    string imagepath = "~/AdminTemplate/CategoryImage/" + fuCatgeoryImage.FileName;

                    fuCatgeoryImage.SaveAs(Server.MapPath(imagepath));

                    cmd = new SqlCommand("sp_InsertCategoryData", con);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@CategoryName", txtCategoryname.Text.Trim());
                    cmd.Parameters.AddWithValue("@IsActive", cbIsActive.Checked);
                    cmd.Parameters.AddWithValue("@ImageUrl", imagepath);

                    int ans = cmd.ExecuteNonQuery();

                    if (ans != 0)
                    {
                        lblmsg.Visible = true;
                        lblmsg.Text = "Data Inserted";
                        lblmsg.CssClass = "alert alert-success";

                        txtCategoryname.Text = "";
                        txtCategoryname.Focus();

                        GetCategoryData();
                    }
                    else
                    {
                        lblmsg.Visible = true;
                        lblmsg.CssClass = "alert alert-danger";
                        lblmsg.Text = "Error";
                    }
                }
                else
                {
                    lblmsg.Visible = true;
                    lblmsg.CssClass = "Please select Image File";
                    lblmsg.Text = "Error";
                }

            }

        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            txtCategoryname.Text = "";
            txtCategoryname.Focus();

            cbIsActive.Checked = false;

            btnAdd.Visible = true;
        }

        public void GetCategoryData()
        {
            cmd = new SqlCommand("sp_DisplayCategoryData", con);
            cmd.CommandType = CommandType.StoredProcedure;

            SqlDataReader drDisplayCategoryData = cmd.ExecuteReader();

            rCategoryData.DataSource = drDisplayCategoryData;
            rCategoryData.DataBind();
        }

        protected void rCategoryData_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            lblmsg.Visible = false;

            if (e.CommandName == "edit")
            {
                int CategoryId = Convert.ToInt32(e.CommandArgument.ToString());

                cmd = new SqlCommand("select * from Category where CategoryId='" + CategoryId + "' ", con);

                SqlDataReader getDatabyID = cmd.ExecuteReader();

                if (getDatabyID.Read())
                {
                    imgCategory.ImageUrl = getDatabyID["ImageUrl"].ToString();
                    txtCategoryname.Text = getDatabyID["CategoryName"].ToString();
                    cbIsActive.Checked = Convert.ToBoolean(getDatabyID["IsActive"].ToString());
                    hfCategoryId.Value = CategoryId.ToString();
                }

                btnAdd.Visible = false;
                btnUpdate.Visible = true;
                btnClear.Text = "Cancel";

            }
            else if (e.CommandName == "delete")
            {
                int CategoryId = Convert.ToInt32(e.CommandArgument.ToString());

                cmd = new SqlCommand("sp_DeleteCategoryData", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@CategoryId", CategoryId);

                int result = cmd.ExecuteNonQuery();

                if (result > 0)
                {
                    lblmsg.Visible = true;
                    lblmsg.Text = "Category Deleted Successfully! ";
                    lblmsg.CssClass = "alert alert-success";

                    GetCategoryData();
                }
                else
                {
                    lblmsg.Visible = true;
                    lblmsg.Text = "Category is assigned with SubCategory ";
                    lblmsg.CssClass = "alert alert-danger";
                }

            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            cmd = new SqlCommand("sp_UpdateCategoryData", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.AddWithValue("@CategoryName", txtCategoryname.Text.Trim());
            cmd.Parameters.AddWithValue("@IsActive", cbIsActive.Checked);
            cmd.Parameters.AddWithValue("@CategoryId", hfCategoryId.Value);

            if (fuCatgeoryImage.HasFile)
            {
                string imagepath = "~/AdminTemplate/CategoryImage/" + fuCatgeoryImage.FileName;

                fuCatgeoryImage.SaveAs(Server.MapPath(imagepath));

                string updateImage = "YES";
                cmd.Parameters.AddWithValue("@UpdateImage", updateImage);
                cmd.Parameters.AddWithValue("@ImageUrl", imagepath);

            }
            else
            {
                string updateImage = "NO";
                cmd.Parameters.AddWithValue("@UpdateImage", updateImage);
                cmd.Parameters.AddWithValue("@ImageUrl", DBNull.Value);
            }

            cmd.ExecuteNonQuery();

            lblmsg.Visible = true;
            lblmsg.Text = "Category Updated";
            lblmsg.CssClass = "alert alert-success";

            GetCategoryData();

            txtCategoryname.Text = "";
            txtCategoryname.Focus();

            cbIsActive.Checked = false;


            btnAdd.Visible = true;
            btnUpdate.Visible = false;
        }
    }
}