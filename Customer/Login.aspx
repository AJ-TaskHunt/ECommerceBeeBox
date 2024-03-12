<%@ Page Title="" Language="C#" MasterPageFile="~/Customer/Customer.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="ECommerceBeeBox.Customer.Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <script>
        //For disappearing alert message

        window.onload = function () {
            var second = 5;
            setTimeout(function () {
                document.getElementById("<%= lblmsg.ClientID %>").style.display = "none";
            }, second * 1000);
        };

    </script>

    <section class="book_section layout_padding">
        <div class="container">
            <div class="heading_container">
                <div class="align-self-lg-end">
                    <asp:Label ID="lblmsg" runat="server"></asp:Label>
                </div>
                <h2>Login</h2>
            </div>
            <div class="row">

                <div class="col-md-6">
                    <div class="form_container">
                        <img id="CustomerLogin" src="../CustomerTemplate/images/bee-box-high-resolution-logo.png" alt="Alternate Text" class="img-thumbnail" />
                    </div>
                </div>


                <div class="col-md-6">
                    <div class="form_container">
                        <div>
                            <asp:RequiredFieldValidator ID="rfvEmailOrMobile" runat="server" ErrorMessage="Please Enter Email/Mobile" ForeColor="Red" Font-Size="Small" Display="Dynamic" SetFocusOnError="true" ControlToValidate="txtEmailOrMobile"></asp:RequiredFieldValidator>
                            <asp:TextBox ID="txtEmailOrMobile" runat="server" CssClass="form-control" placeholder="Email/Mobile"></asp:TextBox>
                        </div>
                        <div>
                            <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ErrorMessage="Please Enter Password" ForeColor="Red" Font-Size="Small" Display="Dynamic" SetFocusOnError="true" ControlToValidate="txtPassword"></asp:RequiredFieldValidator>
                            <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" placeholder="Password" TextMode="Password"></asp:TextBox>
                        </div>

                        <div class="btn_box">
                            <asp:Button ID="btnSignIn" runat="server" Text="Sign In" CssClass="btn btn-success rounded-pill pl-4 pr-4 text-white" OnClick="btnSignIn_Click" />

                            <span class="pl-3 text-info">New Customer? <a href="CustomerRegistration.aspx" class="badge badge-info">Register Here</a> </span>

                        </div>
                        <div class="mt-2">
                            <span class="pl-1 text-dark"><a href="forgottenpassword.aspx"><i class="fa fa-lock mr-2"></i>Forgotten password?</a> </span>

                        </div>
                    </div>
                </div>
            </div>
        </div>

    </section>

</asp:Content>
