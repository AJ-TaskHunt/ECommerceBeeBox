<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LoginForm.aspx.cs" Inherits="ECommerceBeeBox.LoginForm" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <link href="Assets/css/CustomerRegistration.css" rel="stylesheet" />
    <script src="Assets/css/js/CustomerRegistration.js"></script>
    <script src="https://kit.fontawesome.com/64d58efce2.js" crossorigin="anonymous"></script>

    <title>Sign in Form</title>
</head>
<body>
    <div class="container">
        <div class="forms-container">
            <div class="signin-signup">
                <form id="Customerform" runat="server">
                    <a href="Customer/Default.aspx"><img style="width:300px; height:50px; border-width:5px; border-bottom-style:double;"" src="CustomerTemplate/images/bee-box-high-resolution-logo-black-transparent.png" alt="Alternate Text" /></a>
                    <br />
                    <h2 class="title">Sign in</h2>
                    <div class="input-field">
                        <i class="fas fa-user"></i>
                        <%--                        <input type="text" placeholder="Username" />--%>
                        <asp:TextBox ID="txtEmailOrMobile" runat="server" placeholder="Email/Mobile"></asp:TextBox>

                    </div>
                    <div class="input-field">
                        <i class="fas fa-lock"></i>
                        <%--                        <input type="password" placeholder="Password" />--%>
                        <asp:TextBox ID="txtPassword" runat="server" placeholder="Password" TextMode="Password"></asp:TextBox>

                    </div>
                    <%--                    <input type="submit" value="Login" class="btn solid" />--%>
                    <asp:Button ID="btnLogin" runat="server" Class="btn solid" Text="Login" OnClick="btnLogin_Click" />

                    <a href="CustomerRegistration.aspx" class="social-text">Don't have an Account?</a>

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
                        <h3>New Here ?</h3>
                        <p>
                            Lorem ipsum, dolor sit amet consectetur adipisicing elit. Debitis,ex ratione. Aliquid!
                        </p>

                        <button class="btn transparent" id="sign-up-btn" onclick="location.href='CustomerRegistration.aspx';">
                            Sign up
                        </button>
                    </div>
                    <img src="Assets/img/log.svg" class="image" alt="" />
                </div>

            </div>
        </asp:Panel>
    </div>
</body>
</html>
