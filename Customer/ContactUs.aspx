<%@ Page Title="" Language="C#" MasterPageFile="~/Customer/Customer.Master" AutoEventWireup="true" CodeBehind="ContactUs.aspx.cs" Inherits="ECommerceBeeBox.Customer.ContactUs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

    <style>
        .contact-form {
            background: #fff;
            margin-top: 10%;
            margin-bottom: 5%;
            width: 70%;
        }

            .contact-form .form-control {
                border-radius: 1rem;
            }

        .contact-image {
            text-align: center;
        }

            .contact-image img {
                border-radius: 6rem;
                width: 11%;
                margin-top: -3%;
                transform: rotate(29deg);
            }

        .contact-form form {
            padding: 14%;
        }

            .contact-form form .row {
                margin-bottom: -7%;
            }

        .contact-form h3 {
            margin-bottom: 8%;
            margin-top: -10%;
            text-align: center;
            color: #0062cc;
        }

        .contact-form .btnContact {
            width: 50%;
            border: none;
            border-radius: 1rem;
            padding: 1.5%;
            background: #dc3545;
            font-weight: 600;
            color: #fff;
            cursor: pointer;
        }

        .btnContactSubmit {
            width: 50%;
            border-radius: 1rem;
            padding: 1.5%;
            color: #fff;
            background-color: #0062cc;
            border: none;
            cursor: pointer;
        }

        .swal2-select.nice-select {
            display: none !important;
        }

        .nice-select swal2-select open {
            display: none !important;
        }
    </style>

    <script>
        function ContactUs() {

            Swal.fire("Your inquiry has been received and we will take it into consideration. Thank you for reaching out!");
        }

        //for Limit Character In Input Field
        function updateCharacterCount() {
            var Message = document.getElementById('<%= txtMessage.ClientID %>');
            var textLength = document.getElementById('textLimit');
             var MaxChar = 150;

             textLength.textContent = Message.value.length + "/" + MaxChar;
         }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container contact-form">
        <h3>Drop Us a Message</h3>
        <div class="row">
            <div class="col-md-6">
                <div class="form-group">
                    <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="Your Name *"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="txtName" ErrorMessage="Name is required"
                        ForeColor="Red" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="regexName" runat="server" ControlToValidate="txtName" ErrorMessage="Name Must be Character only" ForeColor="Red" Display="Dynamic" SetFocusOnError="true" ValidationExpression="^[a-zA-Z\s]+$"></asp:RegularExpressionValidator>
                </div>
                <div class="form-group">
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="Your Email *"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtEmail" ErrorMessage="Email is required" ForeColor="Red" SetFocusOnError="true" Display="Dynamic">
                    </asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtEmail" ErrorMessage="Invalid Email" ForeColor="Red" Display="Dynamic" SetFocusOnError="true" ValidationExpression="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"></asp:RegularExpressionValidator>

                </div>
                <div class="form-group">
                    <asp:TextBox ID="txtSubject" runat="server" CssClass="form-control" placeholder="Your Subject *"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtSubject" ErrorMessage="Subject is required"
                        ForeColor="Red" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtSubject" ErrorMessage="Subject Must be Character only" ForeColor="Red" Display="Dynamic" SetFocusOnError="true" ValidationExpression="^[a-zA-Z\s]+$"></asp:RegularExpressionValidator>

                </div>
                <div class="form-group">
                    <asp:Button ID="btnSubmit" runat="server" CssClass="btnContact" Text="Send Message" OnClick="btnSubmit_Click" />
                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group">
                    <asp:TextBox ID="txtMessage" runat="server" CssClass="form-control" placeholder="Your Message *" Style="width: 100%; height: 150px;" TextMode="MultiLine" MaxLength="150" oninput="updateCharacterCount()"></asp:TextBox>
                    <p id="textLimit" style="text-align: right; font-size: smaller">0/150</p>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtMessage" ErrorMessage="Message is required"
                        ForeColor="Red" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="txtMessage" ErrorMessage="Message Must be Character only" ForeColor="Red" Display="Dynamic" SetFocusOnError="true" ValidationExpression="^[a-zA-Z\s]+$"></asp:RegularExpressionValidator>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
