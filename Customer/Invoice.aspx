<%@ Page Title="" Language="C#" MasterPageFile="~/Customer/Customer.Master" AutoEventWireup="true" CodeBehind="Invoice.aspx.cs" Inherits="ECommerceBeeBox.Customer.Invoice" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script>
        //For disappearing alert message

        window.onload = function () {
            var second = 5;
            setTimeout(function () {
                document.getElementById("<%= lblmsg.ClientID %>").style.display = "none";
            }, second * 1000);
        };

    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <section class="book_section layout_padding">
        <div class="container">
            <div class="heading_container">
                <div class="align-self-end">
                    <asp:Label ID="lblmsg" runat="server" Visible="false"></asp:Label>
                </div>
            </div>
        </div>

        <div class="container">
            <asp:Repeater ID="rOrderDetails" runat="server">
                <HeaderTemplate>
                    <table class="table table-responsive-sm table-bordered table-hover" id="tblInvoice">
                        <thead class="bg-dark text-white">
                            <tr>
                                <th>Sr.No</th>
                                <th>Order Number</th>
                                <th>Product Name</th>
                                <th>Price</th>
                                <th>Quantity</th>
                                <th>Total Amount</th>
                            </tr>
                            <tbody>
                        </thead>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr>
                        <td>
                            <%# Eval("Srno") %>
                        </td>
                        <td>
                            <%# Eval("OrderNo") %>
                        </td>
                        <td>
                            <%# Eval("ProductName") %>
                        </td>
                        <td>
                            <%# string.IsNullOrEmpty( Eval("Price").ToString() ) ? "" : "₹" + Eval("Price") %>
                        </td>
                        <td>
                            <%# Eval("Quantity") %>
                        </td>
                        <td>₹<%# Eval("TotalAmount") %>
                        </td>
                    </tr>
                </ItemTemplate>
                <FooterTemplate>

                 

                    </tbody>
                    </table>
                </FooterTemplate>
            </asp:Repeater>

            <div class="text-center">
                <asp:LinkButton ID="lbtnDownloadInvoice" runat="server" CssClass="btn btn-warning" OnClick="lbtnDownloadInvoice_Click">
                    <i class="fa fa-file-pdf-o mr-2"></i> Download Invoice
                </asp:LinkButton>
            </div>

        </div>
    </section>


</asp:Content>
