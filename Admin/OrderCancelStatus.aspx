<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="OrderCancelStatus.aspx.cs" Inherits="ECommerceBeeBox.Admin.OrderCancelStatus" %>

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
        <asp:Label ID="lblmsg" runat="server" Visible="false"></asp:Label>
    </div>

    <div class="row">
        <!--Display Order Cancel by Customers-->
        <div class="col-sm-12 col-md-12">
            <div class="card">
                <div class="card-body">
                    <h4 class="card-title">Cancel Order List</h4>
                    <div class="table-responsive">

                        <asp:Repeater ID="rCancelOrderData" runat="server" OnItemCommand="rCancelOrderData_ItemCommand">
                            <HeaderTemplate>
                                <table class="table data-table-export table-hover nowrap">
                                    <thead>
                                        <tr>
                                            <th class="table-plus">#</th>
                                            <th>Order No.</th>
                                            <th>Customer Name</th>
                                            <th>Email</th>
                                            <th>Message</th>
                                            <th>Cancel Date</th>
                                            <th class="dataTable-nosort">Action</th>
                                        </tr>
                                    </thead>

                                    <tbody>
                            </HeaderTemplate>

                            <ItemTemplate>

                                <tr>
                                    <td class="table-plus"><%# Eval("SrNo") %></td>
                                    <td><%# Eval("OrderNo") %></td>
                                    <td><%# Eval("Name") %></td>
                                    <td><%# Eval("Email") %></td>
                                    <td><%# Eval("Message") %></td>
                                    <td><%# Eval("CancelDate") %></td>
                                    <td>
                                        <asp:LinkButton ID="lbtnDelete" runat="server" Text="Delete" CssClass="badge badge-danger" OnClientClick="return confirm('Are you sure You Want to Delete This Record')" CommandArgument='<%# Eval("Id") %>' CommandName="delete" CausesValidation="False">
                                      <i class="icon-trash"></i>
                                        </asp:LinkButton>
                                    </td>
                                </tr>

                            </ItemTemplate>

                            <FooterTemplate>
                                </tbody>
                     </table>
                            </FooterTemplate>
                        </asp:Repeater>

                    </div>
                    <hr />
                </div>
            </div>
        </div>
        <!--Display Order Cancel by Customers-->
    </div>

</asp:Content>
