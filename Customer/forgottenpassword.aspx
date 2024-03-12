<%@ Page Title="" Language="C#" MasterPageFile="~/Customer/Customer.Master" AutoEventWireup="true" CodeBehind="forgottenpassword.aspx.cs" Inherits="ECommerceBeeBox.Customer.forgottenpassword" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script>
        //For disappearing alert message

        window.onload = function () {
            var second = 5;
            setTimeout(function () {
                document.getElementById("<%= lblmsg.ClientID %>").style.display = "none";
            }, second * 1000);
        };

        //alert box
        function showSweetAlert() {
            Swal.fire({
                title: 'Password changed successfully!',
                text: 'Click OK',
                icon: 'success',
                didOpen: () => {
                    // Select the element you want to remove and remove it
                    const niceSelectElement = document.querySelector('.nice-select swal2-select open');
                    const extraElement = document.querySelector('.nice-select swal2-select');

                    if (niceSelectElement || extraElement) {
                        niceSelectElement.remove();
                        extraElement.remove();
                    }
                }
            }).then(function (result) {
                if (result.isConfirmed) {
                    window.location.href = 'Login.aspx';
                }
            });
        }

        function otpcode() {

            Swal.fire("OTP has been sent your Email/Mobile successfully!");
        }
    </script>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

    <!-- form card change password -->
    <div class="container py-5 mr-5">
        <div class="row">
            <div class="col-md-6">
                <div class="card card-outline-secondary">
                    <div class="card-header">
                        <h3 class="mb-0">Forgotten password?</h3>
                        <div class="mt-1 h-50 w-100">
                            <asp:Label ID="lblmsg" runat="server" Visible="false"></asp:Label>
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="form-group">
                            <label>Email/Mobile</label>
                            <asp:TextBox ID="txtEmailMobile" runat="server" CssClass="form-control" placeholder="Enter Email/Mobile"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvCurrentPassword" runat="server" ErrorMessage="Email/Mobile is Required" ControlToValidate="txtEmailMobile" SetFocusOnError="true" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>
                        <div class="form-group">
                            <asp:Button ID="btnGetOTP" runat="server" CssClass="btn btn-warning float-right" Text="Get OTP" OnClick="btnGetOTP_Click" />
                        </div>

                        <br />

                        <asp:Panel ID="panelVerifyOTP" runat="server" Visible="false">

                            <div class="form-group">
                                <label for="inputPasswordOld">Verify OTP</label>
                                <asp:TextBox ID="txtOTP" runat="server" CssClass="form-control" placeholder="Enter OTP"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="OTP is Required" ControlToValidate="txtOTP" SetFocusOnError="true" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>

                        </asp:Panel>

                        <asp:Panel ID="panelResetPassword" runat="server" Visible="false">


                            <div class="form-group">
                                <label for="inputPasswordNew">New Password</label>
                                <ajaxToolkit:PasswordStrength DisplayPosition="BelowRight" ID="PasswordStrength1" runat="server" TargetControlID="txtNewPassword" />
                                <asp:TextBox ID="txtNewPassword" runat="server" TextMode="Password" CssClass="form-control" placeholder="Enter New Password" ToolTip="Enter New Password"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ErrorMessage="New Password is Required" ControlToValidate="txtNewPassword" SetFocusOnError="true" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                            <div class="form-group">
                                <label for="inputPasswordNewVerify">Confirm Password</label>
                                <ajaxToolkit:PasswordStrength DisplayPosition="BelowRight" ID="PasswordStrength2" runat="server" TargetControlID="txtConfirmPassword" />
                                <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" CssClass="form-control" placeholder="Enter Confirm Password" ToolTip="Enter Confirm Password"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvConfirmPassword" runat="server" ErrorMessage="Confirm Password is Required" ControlToValidate="txtConfirmPassword" SetFocusOnError="true" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>

                        </asp:Panel>



                        <div class="form-group">
                            <asp:Button ID="btnVerify" runat="server" CssClass="btn btn-primary float-right" Visible="false" Text="Verify OTP" OnClick="btnVerify_Click" />
                            <asp:Button ID="btnResetPassword" runat="server" CssClass="btn btn-success float-right" Visible="false" Text="Reset Password" OnClick="btnResetPassword_Click" />

                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- /form card change password -->

</asp:Content>
