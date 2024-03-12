using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Net.Mail;

namespace ECommerceBeeBox.Customer
{
    public partial class forgottenpassword : System.Web.UI.Page
    {
        string connectionString = WebConfigurationManager.ConnectionStrings["connection"].ConnectionString.ToString();

        SqlConnection con;
        SqlCommand cmd;

        long OTP = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            con = new SqlConnection(connectionString);
            con.Open();
        }

        protected void btnGetOTP_Click(object sender, EventArgs e)
        {
            string EmailMobile = txtEmailMobile.Text.Trim();

            Random randome = new Random();
            OTP = Convert.ToInt64(randome.Next(1001, 9999));

            ViewState["EmailMobile"] = EmailMobile;

            btnVerify.Visible = true;
            panelVerifyOTP.Visible = true;

            SendOTPCode(EmailMobile);

            ClientScript.RegisterStartupScript(this.GetType(), "alert", "otpcode();", true);

        }

        protected void btnVerify_Click(object sender, EventArgs e)
        {
            long otpCode = Convert.ToInt64(txtOTP.Text = OTP.ToString());

            if (otpCode == OTP)
            {
                lblmsg.Visible = true;
                lblmsg.Text = "OTP Verified successfully!";
                lblmsg.CssClass = "text-success";

                panelVerifyOTP.Visible = false;
                panelResetPassword.Visible = true;

                btnResetPassword.Visible = true;
                btnVerify.Visible = false;
            }
            else
            {
                lblmsg.Visible = true;
                lblmsg.Text = "Cant verify OTP";
                lblmsg.CssClass = "text-danger";

            }

        }

        protected void btnResetPassword_Click(object sender, EventArgs e)
        {
            int pass = Convert.ToInt32(txtNewPassword.Text.Trim());
            int cpass = Convert.ToInt32(txtConfirmPassword.Text.Trim());

            if (OTP != 0)
            {
                if (pass == cpass)
                {
                    cmd = new SqlCommand("update Customer set Password=@pass where Email=@email", con);
                    cmd.Parameters.AddWithValue("@pass", pass);
                    cmd.Parameters.AddWithValue("@email", ViewState["EmailMobile"].ToString());

                    int result = cmd.ExecuteNonQuery();

                    if(result > 0)
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "alert", "showSweetAlert();", true);
                    }
                    
                }
                else
                {
                    lblmsg.Visible = true;
                    lblmsg.Text = "Both Password not matched";
                    lblmsg.CssClass = "text-danger";
                }
            }
            else
            {
                lblmsg.Visible = true;
                lblmsg.Text = "Error in OTP verification";
                lblmsg.CssClass = "text-danger";
            }



        }

        private void SendOTPCode(string emailMobile)
        {

            SmtpClient smtp = new SmtpClient();
            smtp.Host = "smtp.gmail.com";
            smtp.Port = 587;
            smtp.Credentials = new System.Net.NetworkCredential(emailMobile, "wqmn nvqc nbge hbbc");
            smtp.EnableSsl = true;            

            MailMessage msg = new MailMessage();
            msg.Subject = "Verification code";
            msg.Body = "Dear User ,Your activation code is :" + OTP + "\n\n\n Please don't share this otp \n\n\n Thanks & regards";
            string toaddress = emailMobile;
            msg.To.Add(toaddress);
            string fromaddress = "BeeBox <BB.007@gmail.com>";
            msg.From = new MailAddress(fromaddress);
            try
            {
                smtp.Send(msg);
            }
            catch
            {
                throw;
            }
        }
    }
}