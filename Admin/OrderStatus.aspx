<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="OrderStatus.aspx.cs" Inherits="ECommerceBeeBox.Admin.OrderStatus" %>

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

    <div class="mb-4">
        <asp:Label ID="lblmsg" runat="server"></asp:Label>
    </div>

    <div class="row">

        <!--Add or Update Order Status-->
        <asp:Panel ID="pUpdateOrderStatus" runat="server">
            <div class="col-sm-6 col-md-12 col-lg-12">
                <div class="card">
                    <div class="card-body">
                        <h4 class="card-title">Update Order Status</h4>
                        <hr />
                        <asp:HiddenField ID="hfOrderId" runat="server" />

                        <div class="form-body">
                            <label>Order Status</label>
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <asp:DropDownList ID="ddlOrderStatus" runat="server" CssClass="form-control">
                                            <asp:ListItem Value="0">Update Status</asp:ListItem>
                                            <asp:ListItem>Pending</asp:ListItem>
                                            <asp:ListItem>Dispatched</asp:ListItem>
                                            <asp:ListItem>Delivered</asp:ListItem>
                                        </asp:DropDownList>

                                        <asp:RequiredFieldValidator ID="rfvOrderStatus" runat="server" ControlToValidate="ddlOrderStatus" ErrorMessage="*" ForeColor="Red" Display="Dynamic" SetFocusOnError="true" InitialValue="0"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                            </div>

                            <div class="form-action pb-5">
                                <div class="text-left">
                                    <asp:Button ID="btnUpdate" Text="Update" runat="server" CssClass="btn btn-info" OnClick="btnUpdate_Click" />
                                    <asp:Button ID="btnClear" runat="server" CssClass="btn btn-dark" Text="Cancel" OnClick="btnClear_Click" />
                                </div>
                            </div>
                        </div>                        
                    </div>
                </div>
            </div>
        </asp:Panel>
        <!--Add or Update Order Status-->

        <!--Display Order Status-->
        <div class="col-sm-6 col-md-8 col-lg-12">
            <div class="card">
                <div class="card-body">
                    <h4 class="card-title">Order List</h4>
                    <hr />

                    <div class="table-responsive">
                        <asp:Repeater ID="rOrderList" runat="server" OnItemCommand="rOrderList_ItemCommand">
                            <HeaderTemplate>
                                <table class="table data-table-export table-hover nowrap">
                                    <thead>
                                        <tr>
                                            <th class="table-plus">Order No.</th>
                                            <th>Date</th>
                                            <th>Status</th>
                                            <th>Product Name</th>
                                            <th>Quantity</th>
                                            <th>Total Price</th>
                                            <th>Payment Mode</th>
                                            <th>IsCancel By Customer</th>
                                            <th class="dataTable-nosort">Edit</th>
                                        </tr>
                                    </thead>

                                    <tbody>
                            </HeaderTemplate>

                            <ItemTemplate>

                                <tr>
                                    <td class="table-plus"><%# Eval("OrderNo") %></td>
                                    <td>
                                        <%# Eval("OrderDate") %>
                                    </td>

                                    <td>
                                        <asp:Label ID="lblOrderStatus" runat="server" Text='<%# Eval("Status") %>' CssClass='<%# Eval("Status").ToString() == "Pending" ? "badge badge-warning" : "badge badge-success" %>'>
                                        </asp:Label>
                                    </td>

                                    <td>
                                        <%# Eval("ProductName") %>
                                    </td>
                                    <td><%# Eval("Quantity") %></td>

                                    <td><%# Eval("TotalPrice") %></td>

                                    <td><%# Eval("PaymentMode") %></td>

                                    <td>
                                        <asp:Label ID="lblIsActive" runat="server" Text='<%# (bool)Eval("IsCancel") == true ? "Not Cancel" : "Canceled" %>' CssClass='<%# (bool)Eval("IsCancel") == true ? "badge badge-success" : "badge badge-danger" %>'></asp:Label>
                                    </td>

                                    <td>
                                        <asp:LinkButton ID="lbtnEditButton" runat="server" Text="Edit" CssClass="badge badge-primary" CommandArgument='<%# Eval("OrderDetailsId") %>' CommandName="edit" CausesValidation="False">
                                        <i class="fas fa-edit"></i>
                                        </asp:LinkButton>
                                    </td>
                                </tr>
                            </ItemTemplate>

                            <FooterTemplate>
                                </tbody>
                             </table>
                            </FooterTemplate>
                        </asp:Repeater>

                        <div>
                            <asp:Label ID="lblNoOrder" runat="server" Text="No Order" Visible="false"></asp:Label>
                        </div>

                    </div>
                </div>
            </div>
        </div>
        <!--Display Order Status-->
    </div>

</asp:Content>
