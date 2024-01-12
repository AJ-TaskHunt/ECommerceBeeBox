<%@ Page Title="" Language="C#" MasterPageFile="~/Customer/Customer.Master" AutoEventWireup="true" CodeBehind="Cart.aspx.cs" Inherits="ECommerceBeeBox.Customer.Cart" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script>

        function CartUpdated() {

            Swal.fire("Cart updated successfully!");
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

    <section class="book_section layout_padding">
        <div class="container">
            <div class="heading_container">
                <div class="align-self-end">
                    <asp:Label ID="lblmsg" runat="server" Visible="false"></asp:Label>
                </div>
                <h4>Your Shopping Cart</h4>
            </div>
        </div>

        <div class="container">
            <asp:Repeater ID="rCartItem" runat="server" OnItemCommand="rCartItem_ItemCommand" OnItemDataBound="rCartItem_ItemDataBound">
                <HeaderTemplate>
                    <table class="table">
                        <thead>
                            <tr>
                                <th class="table-plus">Product Name</th>
                                <th>Image</th>
                                <th>Price</th>
                                <th>Quantity</th>
                                <th>Total Price</th>
                            </tr>
                        </thead>

                        <tbody>
                </HeaderTemplate>

                <ItemTemplate>

                    <tr>
                        <td>
                            <asp:Label ID="lblName" runat="server" Text='<%# Eval("ProductName") %> '></asp:Label>
                        </td>
                        <td>
                            <asp:Image ID="imgProduct" runat="server" ImageUrl='<%# Eval("ProductImageUrl") %>' Width="60px" Height="60px" />
                        </td>
                        <td>₹<asp:Label ID="lblPrice" runat="server" Text='<%# Eval("Price") %> '></asp:Label>
                            <asp:HiddenField ID="hfProductId" runat="server" Value='<%# Eval("pId") %>' />
                            <asp:HiddenField ID="hfQuantity" runat="server" Value='<%# Eval("Qty") %>' />
                            <asp:HiddenField ID="hfProductQty" runat="server" Value='<%# Eval("ProductQty") %>' />

                        </td>

                        <td>
                            <div class="product__details__option">
                                <div class="quantity">
                                    <div class="pro-qty">
                                        <span class="dec qtybtn text-danger"><i class="fa fa-minus-circle"></i></span>
                                        <asp:TextBox ID="txtQty" runat="server" TextMode="Number" Text='<%# Eval("Quantity") %>'></asp:TextBox>
                                        <span class="inc qtybtn text-success"><i class="fa fa-plus-circle"></i></span>

                                    </div>
                                </div>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic" Font-Size="Small" ValidationExpression="[1-9]*" ControlToValidate="txtQty" SetFocusOnError="true" EnableClientScript="true"></asp:RegularExpressionValidator>
                            </div>
                        </td>

                        <td>₹<asp:Label ID="lblTotalPrice" runat="server" Text="0"></asp:Label>
                        </td>

                        <td>
                            <asp:LinkButton ID="lbtnRemoveItem" runat="server" Text="Remove" CommandName="remove" ToolTip="Remove Item"
                                CommandArgument='<%# Eval("ProductId") %>'
                                OnClientClick="return confirm('Do you want to remove this item from cart?');">
                                <i class="fa fa-close"></i>
                            </asp:LinkButton>
                        </td>

                    </tr>

                </ItemTemplate>

                <FooterTemplate>
                    <tr>
                        <td colspan="3"></td>
                        <td class="pl-lg-5">
                            <b>Total Amount :- </b>
                        </td>
                        <td>₹<% Response.Write(Session["TotalAmount"]); %></td>
                        <td></td>
                    </tr>

                    <tr>
                        <td colspan="2" class="continue__btn">
                            <a href="Default.aspx" class="btn btn-info">
                                <i class="fa fa-arrow-circle-o-left mr-2"></i>Continue Shopping
                            </a>
                        </td>
                        <td>
                            <asp:LinkButton ID="lbtnUpdateCart" runat="server" CommandName="UpdateCart" CssClass="btn btn-warning">
                                <i class="fa fa-refresh mr-2"></i>Update Cart
                            </asp:LinkButton>
                        </td>
                        <td>
                            <asp:LinkButton ID="lbtnCheckout" runat="server" CommandName="checkout" CssClass="btn btn-success">
                                Checkout<i class="fa fa-arrow-circle-o-right ml-2"></i>
                            </asp:LinkButton>
                        </td>
                    </tr>
                    </tbody>
            </table>
                </FooterTemplate>

            </asp:Repeater>

            <div class="text-center">
                <asp:Label ID="lblCartEmpty" Visible="false" runat="server" Text="<h2>Your Cart is empty.. </h2>" CssClass="text-black-50"></asp:Label>

            </div>
        </div>

    </section>

</asp:Content>
