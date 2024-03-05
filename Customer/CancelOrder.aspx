<%@ Page Title="" Language="C#" MasterPageFile="~/Customer/Customer.Master" AutoEventWireup="true" CodeBehind="CancelOrder.aspx.cs" Inherits="ECommerceBeeBox.Customer.CancelOrder" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script>
        function OrderCancel() {

            Swal.fire({
                title: 'Your Order Canceled Succefully!',
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

        //for Limit Character In Input Field
        function updateCharacterCount() {
            var Message = document.getElementById('<%= txtMessage.ClientID %>');
            var textLength = document.getElementById('textLimit');
            var MaxChar = 150;

            textLength.textContent = Message.value.length + "/" + MaxChar;
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

    <div class="container py-5">
        <div class="row">
            <div class="col-md-12">

                <div class="row">
                    <!--/col-->
                    <div class="col-md-6 offset-md-3">
                        <span class="anchor" id="formContact"></span>
                        <!-- form user info -->
                        <div class="card card-outline-secondary">
                            <div class="card-header">
                                <h3 class="mb-0">Order Cancel</h3>
                                <h4 class="mb-3"><span>Product Name :: </span><% Response.Write(Session["PName"]); %></h4>
                            </div>
                            <div class="card-body">
                                <fieldset>
                                    <div class="row mb-1">
                                        <div class="col-lg-12">
                                            <asp:TextBox ID="txtMessage" runat="server" CssClass="form-control" placeholder="Your Message *" Style="width: 100%; height: 120px;" TextMode="MultiLine" MaxLength="150" oninput="updateCharacterCount()"></asp:TextBox>
                                            <p id="textLimit" style="text-align: right; font-size: smaller">0/150</p>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtMessage" ErrorMessage="Message is required"
                                                ForeColor="Red" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="txtMessage" ErrorMessage="Message Must be Character only" ForeColor="Red" Display="Dynamic" SetFocusOnError="true" ValidationExpression="^[a-zA-Z\s]+$"></asp:RegularExpressionValidator>
                                        </div>
                                    </div>
                                    <div class="mt-1">
                                        <asp:Button ID="btnCancelOrder" runat="server" CssClass="btn btn-secondary btn-lg float-right" Text="Cancel Order" OnClick="btnCancelOrder_Click" />
                                    </div>
                                </fieldset>

                            </div>
                        </div>
                        <!-- /form user info -->

                    </div>
                    <!--/col-->
                </div>

            </div>
        </div>
    </div>

</asp:Content>
