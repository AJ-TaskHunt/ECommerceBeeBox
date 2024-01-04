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
    public partial class SubCategory : System.Web.UI.Page
    {
        string connectionStirng = WebConfigurationManager.ConnectionStrings["connection"].ConnectionString.ToString();

        SqlConnection con;
        SqlCommand cmd;

        protected void Page_Load(object sender, EventArgs e)
        {
            con = new SqlConnection(connectionStirng);
            con.Open();

            if (Session["AdminUser"] == null)
            {
                Response.Redirect("AdminLogin.aspx");
            }

            if (!IsPostBack)
            {
                ddlCategoryData();
                getSubCategoryData();
            }

            lblmsg.Visible = false;
            btnUpdateSubCategory.Visible = false;

            btnClear.Text = "Reset";    
        }

        protected void btnAddSubCategory_Click(object sender, EventArgs e)
        {
            cmd = new SqlCommand("sp_CheckSubCategorySpecificData",con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.AddWithValue("@SubCategoryName",ddlSubCategoryName.SelectedItem.Value);

            SqlDataReader drCheckSubCategoryName =  cmd.ExecuteReader();

            if (drCheckSubCategoryName.Read())
            {
                lblmsg.Visible = true;
                lblmsg.Text = "SubCategory Alerdy exists";
                lblmsg.CssClass = "alert alert-danger";

                ddlSubCategoryName.SelectedIndex = 0;

            }
            else
            {
                drCheckSubCategoryName.Close();
                int CategoryId = Convert.ToInt32(ddlCategoryName.SelectedValue);

                cmd = new SqlCommand("sp_InsertSubCategory", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@SubCategoryName", ddlSubCategoryName.SelectedItem.Value);
                cmd.Parameters.AddWithValue("@CategoryId", CategoryId);
                cmd.Parameters.AddWithValue("@IsActive", cbIsActive.Checked);

                int InsertSubCategory = cmd.ExecuteNonQuery();

                if (InsertSubCategory != 0)
                {
                    lblmsg.Visible = true;
                    lblmsg.Text = "SubCategory Added successfully!";
                    lblmsg.CssClass = "alert alert-success";

                    ddlCategoryName.SelectedIndex = 0;
                    ddlSubCategoryName.SelectedIndex = 0;

                    cbIsActive.Checked = false;

                    getSubCategoryData();
                }
                else
                {
                    lblmsg.Visible = true;

                    lblmsg.CssClass = "alert alert-danger";
                    lblmsg.Text = "Error";

                    ddlCategoryName.SelectedIndex = 0;
                    ddlSubCategoryName.SelectedIndex = 0;

                    cbIsActive.Checked = false;

                }
            }

           
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            ddlCategoryName.SelectedIndex = 0;
            ddlSubCategoryName.SelectedIndex = 0;

            cbIsActive.Checked = false;

            btnAddSubCategory.Visible = true;
        }

        public void ddlCategoryData()
        {
            cmd = new SqlCommand("select * from Category where IsActive=1",con);

            SqlDataReader dr = cmd.ExecuteReader();

            ddlCategoryName.DataSource = dr;
            ddlCategoryName.DataTextField = "CategoryName";
            ddlCategoryName.DataValueField = "CategoryId";
            ddlCategoryName.DataBind();
            ddlCategoryName.Items.Insert(0, new ListItem("Select Category", "0"));

            dr.Close();
        }

        public void getSubCategoryData()
        {
           
            cmd = new SqlCommand("select sub.*, cat.CategoryName as CategoryName from SubCategory sub inner join Category cat on cat.CategoryId = sub.CategoryId where cat.IsActive=1 order by sub.CreateDate desc", con);
 
            SqlDataReader drDisplaySubCategoryData = cmd.ExecuteReader();

            rSubCategoryData.DataSource = drDisplaySubCategoryData;
            rSubCategoryData.DataBind();
        }

        protected void btnUpdateSubCategory_Click(object sender, EventArgs e)
        {
            cmd = new SqlCommand("sp_UpdateSubCategory", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.AddWithValue("@SubCategoryName",ddlSubCategoryName.SelectedItem.Value);
            cmd.Parameters.AddWithValue("@CategoryId",ddlCategoryName.SelectedValue);
            cmd.Parameters.AddWithValue("@IsActive",cbIsActive.Checked);
            cmd.Parameters.AddWithValue("@SubCategoryId",hfSubCategoryId.Value);

           int updateSubCategory =  cmd.ExecuteNonQuery();

            if(updateSubCategory!=0)
            {
                lblmsg.Visible=false;
                lblmsg.Text = "SubCategory Updated successfully!";
                lblmsg.CssClass = "alert alert-success";

                getSubCategoryData();

                ddlCategoryName.SelectedIndex = 0;
                ddlSubCategoryName.SelectedIndex = 0;

                cbIsActive.Checked = false;
            }

            btnUpdateSubCategory.Visible = false;
            btnAddSubCategory.Visible = true;

           
        }

        protected void rSubCategoryData_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            lblmsg.Visible = false;

            if(e.CommandName == "edit")
            {
                cmd  = new SqlCommand("select * from SubCategory where SubCategoryId='"+e.CommandArgument+"'",con);

                SqlDataReader drUpdateSubCategory = cmd.ExecuteReader();

                if(drUpdateSubCategory.Read())
                {
                    ddlCategoryName.SelectedValue = drUpdateSubCategory["CategoryId"].ToString();
                    ddlSubCategoryName.SelectedValue = drUpdateSubCategory["SubCategoryName"].ToString();
                    cbIsActive.Checked = Convert.ToBoolean(drUpdateSubCategory["IsActive"].ToString());

                    hfSubCategoryId.Value=e.CommandArgument.ToString();
                }

                btnAddSubCategory.Visible= false;
                btnUpdateSubCategory.Visible= true;

                btnClear.Text = "Cancel";

            }

            if(e.CommandName == "delete")
            {
                cmd = new SqlCommand("sp_DeleteSubCategoryData", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@SubCategoryId",e.CommandArgument.ToString());

                cmd.ExecuteNonQuery();

                lblmsg.Visible = false;
                lblmsg.Text= "SubCategory Deleted successfully!";
                lblmsg.CssClass = "alert alert-success";

                getSubCategoryData();

            }

        }
    }
}