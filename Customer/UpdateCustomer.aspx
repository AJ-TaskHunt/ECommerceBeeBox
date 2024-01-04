<%@ Page Title="" Language="C#" MasterPageFile="~/Customer/Customer.Master" AutoEventWireup="true" CodeBehind="UpdateCustomer.aspx.cs" Inherits="ECommerceBeeBox.Customer.UpdateCustomer" %>

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

        //for Image Preview
        function ImagePreview(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();

                reader.onload = function (e) {
                    $('#<%=imgProfile.ClientID %>').prop('src', e.target.result)
                        .width(200)
                        .height(200);
                };
                reader.readAsDataURL(input.files[0]);
            }
        }

    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <asp:ScriptManager runat="server"></asp:ScriptManager>


    <div class="container mt-4">
        <div class="row gutters">
            <div class="col-xl-3 col-lg-3 col-md-12 col-sm-12 col-12">
                <!-- Profile picture card-->
                <div class="card mb-4 mb-xl-0">

                    <div class="card-body text-center">
                        <!-- Profile picture image-->
                        <asp:Image ID="imgProfile" runat="server" CssClass="img-thumbnail" Width="200px" Height="200" />
                        <!-- Profile picture upload button-->
                        <br />
                        <asp:FileUpload ID="fuImageProfile" runat="server" onchange="ImagePreview(this);" CssClass="form-control" ToolTip="Customer Image" accept=".png,.jpg,.jpeg" />
                        <asp:RegularExpressionValidator ID="regexImage" runat="server" ForeColor="Red" Font-Size="Small" Display="Dynamic" SetFocusOnError="true" ControlToValidate="fuImageProfile" ValidationExpression="(.*?)\.(jpg|png|jpeg)$" ErrorMessage="Only .jpg .png .jpeg image file are allowed "></asp:RegularExpressionValidator>
                    </div>
                </div>


                <div class="mb-6 text-center pt-4">
                    <asp:Label ID="lblmsg" runat="server"></asp:Label>
                </div>
            </div>

            <div class="col-xl-8">
                <div class="card mb-4">
                    <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12 pt-2">
                        <h4 class="mb-2 text-primary">Personal Details</h4>
                    </div>

                    <div class="card-body">

                        <!--Name Field -->
                        <div class="mb-3">
                            <asp:RequiredFieldValidator ID="rfvName" runat="server" ErrorMessage="Name is Required" ControlToValidate="txtName" SetFocusOnError="true" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                            <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="Enter Name" ToolTip="Enter Name"></asp:TextBox>
                            <asp:RegularExpressionValidator ID="reName" runat="server" ErrorMessage="Name Must be in character only" ValidationExpression="^[a-zA-Z\s]+$" ControlToValidate="txtName" ForeColor="Red" SetFocusOnError="true" Display="Dynamic"></asp:RegularExpressionValidator>
                        </div>

                        <!--Address Field -->
                        <div class="mb-3">
                            <asp:RequiredFieldValidator ID="rfvAddress" runat="server" ErrorMessage="Address is Required" ControlToValidate="txtAddress" SetFocusOnError="true" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                            <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" placeholder="Enter Address" TextMode="MultiLine" ToolTip="Enter Address"></asp:TextBox>
                        </div>

                        <hr id="hrLine1" class="mt-0 mb-4">

                        <!--Email, Mobile, PostCode Field  -->
                        <div class="row gx-3 mb-3">
                            <div class="col-md-6">
                                <asp:RequiredFieldValidator ID="rgvEmail" runat="server" ErrorMessage="Email is Required" ControlToValidate="txtEmail" SetFocusOnError="true" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="Enter Email" ToolTip="Enter Email"></asp:TextBox>
                                <asp:RegularExpressionValidator ID="reEmail" runat="server" ErrorMessage="Please enter a valid Email" ValidationExpression="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$" ControlToValidate="txtEmail" ForeColor="Red" SetFocusOnError="true" Display="Dynamic"></asp:RegularExpressionValidator>
                            </div>
                            <div class="col-md-6">
                                <asp:RequiredFieldValidator ID="rfvMobile" runat="server" ErrorMessage="Mobile Number is Required" ControlToValidate="txtMobile" SetFocusOnError="true" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                                <asp:TextBox ID="txtMobile" runat="server" CssClass="form-control" placeholder="Enter Mobile Number" ToolTip="Enter Mobile Number"></asp:TextBox>
                                <asp:RegularExpressionValidator ID="reMobile" runat="server" ErrorMessage="Mobile number must be in 10 digits only" ValidationExpression="^\d{10}$" ControlToValidate="txtMobile" ForeColor="Red" SetFocusOnError="true" Display="Dynamic"></asp:RegularExpressionValidator>
                            </div>

                            <div class="col-md-6 pt-3">
                                <asp:RequiredFieldValidator ID="rfvPostCode" runat="server" ErrorMessage="Post/Zip Code is Required" ControlToValidate="txtPostCode" SetFocusOnError="true" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                                <asp:TextBox ID="txtPostCode" runat="server" CssClass="form-control" placeholder="Enter Post/Zip Code" ToolTip="Enter Post/Zip Code"></asp:TextBox>
                                <asp:RegularExpressionValidator ID="rePostCode" runat="server" ErrorMessage="Please enter a valid Post/Zip Code" ValidationExpression="^[0-9]{6}$" ControlToValidate="txtPostCode" ForeColor="Red" SetFocusOnError="true" Display="Dynamic"></asp:RegularExpressionValidator>
                            </div>

                        </div>

                        <hr id="hrLine2" class="mt-0 mb-4">

                        <!--Password Field -->
                        <div class="row gx-3 mb-3">
                            <div class="col-md-6">
                                <ajaxToolkit:PasswordStrength DisplayPosition="AboveLeft" ID="PasswordStrength3" runat="server" TargetControlID="txtCurrentPssword" />
                                <asp:RequiredFieldValidator ID="rfvCurrentPassword" runat="server" ErrorMessage="Current Password is Required" ControlToValidate="txtCurrentPssword" SetFocusOnError="true" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                                <asp:TextBox ID="txtCurrentPssword" runat="server" TextMode="Password" CssClass="form-control" placeholder="Enter Current Password" ToolTip="Enter Current Password"></asp:TextBox>
                            </div>
                            <div class="col-md-6">
                                <ajaxToolkit:PasswordStrength DisplayPosition="AboveLeft" ID="PasswordStrength1" runat="server" TargetControlID="txtNewPassword" />
                                <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ErrorMessage="New Password is Required" ControlToValidate="txtNewPassword" SetFocusOnError="true" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                                <asp:TextBox ID="txtNewPassword" runat="server" TextMode="Password" CssClass="form-control" placeholder="Enter New Password" ToolTip="Enter New Password"></asp:TextBox>
                            </div>
                            <div class="col-md-6 pt-3">
                                <ajaxToolkit:PasswordStrength DisplayPosition="BelowRight" ID="PasswordStrength2" runat="server" TargetControlID="txtConfirmPassword" />
                                <asp:RequiredFieldValidator ID="rfvConfirmPassword" runat="server" ErrorMessage="Confirm Password is Required" ControlToValidate="txtConfirmPassword" SetFocusOnError="true" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                                <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" CssClass="form-control" placeholder="Enter Confirm Password" ToolTip="Enter Confirm Password"></asp:TextBox>
                            </div>
                        </div>

                        <!--Button -->
                        <asp:Button ID="btnUpdate" runat="server" Text="Update" CssClass="btn btn-primary" OnClick="btnUpdate_Click" />
                        &nbsp;
                        <asp:Button CausesValidation="false" ID="btnReset" runat="server" Text="Reset" CssClass="btn btn-danger" />
                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
