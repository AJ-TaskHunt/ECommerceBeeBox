<%@ Page Title="" Language="C#" MasterPageFile="~/Customer/Customer.Master" AutoEventWireup="true" CodeBehind="ChangePassword.aspx.cs" Inherits="ECommerceBeeBox.Customer.ChangePassword" %>

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
                text: 'Click OK to go back to Profile',
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
                    window.location.href = 'MyProfile.aspx';
                }
            });
        }
    </script>

    <style>
        .swal2-select.nice-select {
            display: none !important;
        }

        .nice-select swal2-select open {
            display: none !important;
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

    <!-- form card change password -->
    <div class="container py-5 mr-5">
        <div class="row">
            <div class="col-md-6">
                <div class="card card-outline-secondary">
                    <div class="card-header">
                        <h3 class="mb-0">Change Password</h3>
                        <div class="mt-1 h-50 w-100">
                            <asp:Label ID="lblmsg" runat="server"></asp:Label>
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="form-group">
                            <label for="inputPasswordOld">Current Password</label>
                            <ajaxToolkit:PasswordStrength DisplayPosition="BelowRight" ID="PasswordStrength3" runat="server" TargetControlID="txtCurrentPssword" />
                            <asp:TextBox ID="txtCurrentPssword" runat="server" TextMode="Password" CssClass="form-control" placeholder="Enter Current Password" ToolTip="Enter Current Password"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvCurrentPassword" runat="server" ErrorMessage="Current Password is Required" ControlToValidate="txtCurrentPssword" SetFocusOnError="true" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>
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

                        <div class="form-group">
                            <asp:Button ID="btnChangePassword" runat="server" CssClass="btn btn-warning float-right" Text="Change Password" OnClick="btnChangePassword_Click" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- /form card change password -->

</asp:Content>
