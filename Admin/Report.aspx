<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Report.aspx.cs" Inherits="ECommerceBeeBox.Admin.Report" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="mb-4">
        <asp:Label ID="lblmsg" runat="server" Visible="false"></asp:Label>
    </div>

    <div class="row">
        <!--Add or Update Product-->
        <div class="col-sm-8 col-md-8">
            <div class="card">
                <div class="card-body">
                    <div class="form-row">
                        <div class="form-group col-md-4">
                            <label>From Date</label>
                            <%--<asp:RegularExpressionValidator ID="rfv1" runat="server" ControlToValidate="txtFromDate" ForeColor="Red" Display="Dynamic" SetFocusOnError="true" ErrorMessage="*"></asp:RegularExpressionValidator>--%>
                            <asp:TextBox ID="txtFromDate" runat="server" TextMode="Date" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="form-group col-md-4">
                            <label>To Date</label>
                            <%--<asp:RegularExpressionValidator ID="rfv2" runat="server" ControlToValidate="txtToDate" ForeColor="Red" Display="Dynamic" SetFocusOnError="true" ErrorMessage="*"></asp:RegularExpressionValidator>--%>
                            <asp:TextBox ID="txtToDate" runat="server" TextMode="Date" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="form-group col-md-4">
                            <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-primary mt-md-4" OnClick="btnSearch_Click" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--End Add or Update Category-->

        <!--Display Category-->
        <div class="col-sm-12 col-md-12">
            <div class="card">
                <div class="card-body">
                    <h4 class="card-title">Selling Report</h4>
                    <div class="table-responsive">

                        <asp:Repeater ID="rReport" runat="server">
                            <HeaderTemplate>
                                <table class="table data-table-export table-hover nowrap">
                                    <thead>
                                        <tr>
                                            <th class="table-plus">#</th>
                                            <th>Name</th>
                                            <th>Email</th>
                                            <th>Item Order</th>
                                            <th>Total Cost</th>
                                        </tr>
                                    </thead>

                                    <tbody>
                            </HeaderTemplate>

                            <ItemTemplate>

                                <tr>
                                    <td class="table-plus"><%# Eval("SrNo") %></td>
                                    <td><%# Eval("Name") %></td>
                                    <td><%# Eval("Email") %></td>
                                    <td><%# Eval("TotalOrder") %></td>
                                    <td><%# Eval("TotalPrice") %></td>
                                </tr>

                            </ItemTemplate>

                            <FooterTemplate>
                                </tbody>
                         </table>
                            </FooterTemplate>
                        </asp:Repeater>

                    </div>
                    <hr />
                    <div class="row pl-3">
                        <asp:Label ID="lblTotal" runat="server" Font-Bold="true" Font-Size="Small"></asp:Label>
                    </div>
                </div>
            </div>
        </div>


        <!--Display Category-->
    </div>


</asp:Content>
