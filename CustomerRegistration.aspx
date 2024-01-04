<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CustomerRegistration.aspx.cs" Inherits="ECommerceBeeBox.CustomerRegistration" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <link href="Assets/css/CustomerRegistration.css" rel="stylesheet" />
    <script src="Assets/css/js/CustomerRegistration.js"></script>
    <script src="https://kit.fontawesome.com/64d58efce2.js" crossorigin="anonymous"></script>

    <title>Sign up Form</title>

    <style>

        .error {
                color: red;
                 font-weight: bold;
                font-size: small;
           }

    </style>

</head>
<body>

    <%--Validation--%>
    <script type="text/javascript">

        //for Name
        function Name() {
            var name = document.getElementById('<%= txtName.ClientID %>');
            var spanname = document.getElementById('txtNameError');
            var regex1 = /^[a-zA-Z\s]*$/;

            // Check if the Name is not empty
            if (name.value.trim() === '' || !regex1.test(name.value)) {
                spanname.innerText = 'Please enter a valid Name';
            } else {
                spanname.innerText = '';
            }
        }

        //for Email
        function Email() {

            var email = document.getElementById('<%= txtEmail.ClientID %>');
            var spmalEmail = document.getElementById('emailError');
            var regex2 = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;

            // Check if the Email is not empty
            if (email.value.trim() === '' || !regex2.test(email.value)) {
                spmalEmail.innerText = 'Please enter a valid Email';
            } else {
                spmalEmail.innerText = '';
            }
        }


        //for Mobile
        function Mobile() {

            var mobile = document.getElementById('<%= txtMobile.ClientID %>');
            var spanMobile = document.getElementById('MobileError');
            var regex3 = /^\d{10}$/;


            // Check if the Mobile is not empty
            if (mobile.value.trim() === '' || !regex3.test(mobile.value)) {
                spanMobile.innerText = 'Please enter a valid Mobile';
            } else {
                spanMobile.innerText = '';
            }
        }


        //for Password
        <%--function Password() {
            var pass = document.getElementById('<%= txtPassword.ClientID %>');
            var pass2 = document.getElementById('<%= txtConfirmPassword.ClientID %>');
            var SpanPassword = document.getElementById('passError');
            var regex9 = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/;

            // Check if the Password is not empty and meets the requirements
            if (pass.value.trim() === '' || !regex9.test(pass.value)) {
                SpanPassword.innerText = 'Please enter a valid password';
            }
            else {
                SpanPassword.innerText = '';
            }
        }

        //for Confirm Password
        function ConfirmPassword() {
            var pass2 = document.getElementById('<%= txtConfirmPassword.ClientID %>');
            var SpanPassword = document.getElementById('CpassError');
            var regex9 = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/;

            // Check if the Password is not empty and meets the requirements
            if (pass2.value.trim() === '' || !regex9.test(pass2.value)) {
                SpanPassword.innerText = 'Please enter a valid Confirm password';
            }
            else {
                SpanPassword.innerText = '';
            }
        }--%> 

    </script>


    <div class="container">
        <div class="forms-container">
            <div class="signin-signup">
                <form action="#" id="Customerform" runat="server">
                        <asp:ScriptManager runat="server"></asp:ScriptManager>

                    <a href="Customer/Default.aspx">
                        <img style="width: 300px; height: 40px; border-width: 5px; border-bottom-style: double;" src="CustomerTemplate/images/bee-box-high-resolution-logo-black-transparent.png" alt="Alternate Text" /></a>
                    <h2 class="title">Sign up</h2>

                        <!-----Name-------------------------------------------------------------------->
                        <asp:RequiredFieldValidator ID="rfvName" runat="server" ErrorMessage="Name is Required" ControlToValidate="txtName" SetFocusOnError="true" Display="Dynamic" Font-Size="Small" ForeColor="Red"></asp:RequiredFieldValidator>
                    <div class="input-field">
                        <i class="fas fa-user"></i>
                        <asp:TextBox ID="txtName" runat="server" placeholder="Name" onkeyup="Name()" ClientIDMode="Static"></asp:TextBox>
                    </div>
                    <span id="txtNameError" class="error"></span>

                    <!-------Email------------------------------------------------------------------>
                    <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ErrorMessage="Email is Required" ControlToValidate="txtEmail" SetFocusOnError="true" Display="Dynamic" Font-Size="Small" ForeColor="Red"></asp:RequiredFieldValidator>
                    <div class="input-field">
                        <i class="fas fa-envelope"></i>
                        <asp:TextBox ID="txtEmail" runat="server" placeholder="Email" onkeyup="Email()" ClientIDMode="Static"></asp:TextBox>                        
                    </div>
                    <span id="emailError" class="error"></span>

                    <!--------Mobile----------------------------------------------------------------->
                    <asp:RequiredFieldValidator ID="rfvMobile" runat="server" ErrorMessage="Contact No is Required" ControlToValidate="txtMobile" SetFocusOnError="true" Display="Dynamic" Font-Size="Small" ForeColor="Red"></asp:RequiredFieldValidator>
                    <div class="input-field">
                        <i class="fas fa-user"></i>
                        <asp:TextBox ID="txtMobile" runat="server" placeholder="Contact No" onkeyup="Mobile()" ClientIDMode="Static"></asp:TextBox>                        
                    </div>
                    <span id="MobileError" class="error"></span>

                    <!-----------Password-------------------------------------------------------------->
                    <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ErrorMessage="Password is Required" ControlToValidate="txtPassword" SetFocusOnError="true" Display="Dynamic" Font-Size="Small" ForeColor="Red"></asp:RequiredFieldValidator>
                    <div class="input-field">
                        <i class="fas fa-lock"></i>
                        <asp:TextBox ID="txtPassword" runat="server" placeholder="Password" TextMode="Password" onkeyup="Password()" ClientIDMode="Static"></asp:TextBox>                        
                    </div>
                    <ajaxToolkit:PasswordStrength ID="PasswordStrength1" runat="server" TargetControlID="txtPassword" />
                    <span id="passError" class="error"></span>

                    <!------------Confirm Password------------------------------------------------------------->
                    <asp:RequiredFieldValidator ID="rfvCPass" runat="server" ErrorMessage="Confirm Password is Required" ControlToValidate="txtConfirmPassword" SetFocusOnError="true" Display="Dynamic" Font-Size="Small" ForeColor="Red"></asp:RequiredFieldValidator>
                    <div class="input-field">
                        <i class="fas fa-lock"></i>
                        <asp:TextBox ID="txtConfirmPassword" runat="server" placeholder="Confirm Password" TextMode="Password" onkeyup="ConfirmPassword()" ClientIDMode="Static"></asp:TextBox>
                    </div><ajaxToolkit:PasswordStrength ID="PasswordStrength2" runat="server" TargetControlID="txtConfirmPassword" />
                    <span id="CpassError" class="error"></span>

                    <!---------Button---------------------------------------------------------------->
                    <asp:Button ID="btnSingUp" runat="server" Text="Sign Up" Class="btn" OnClick="btnSingUp_Click" />

                    <br />

                    <div style="text-align: center">
                        <asp:Label ID="lblmsg" runat="server"></asp:Label>
                    </div>

                </form>

            </div>
        </div>

        <asp:Panel ID="panel1" runat="server">
            <div class="panels-container">
                <div class="panel left-panel">
                    <div class="content">
                        <h3>Alrady have an Account?</h3>
                        <p>
                            Lorem ipsum, dolor sit amet consectetur adipisicing elit. Debitis,
              ex ratione. Aliquid!
                        </p>

                        <button class="btn transparent" id="sign-up-btn" onclick='location.href="LoginForm.aspx"'>Sign in</button>

                    </div>
                    <img src="Assets/img/log.svg" class="image" alt="" />
                </div>
            </div>
        </asp:Panel>
    </div>
</body>
</html>
