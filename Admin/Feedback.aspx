<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Feedback.aspx.cs" Inherits="ECommerceBeeBox.Admin.Feedback" %>

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
        <!--Display Feedback-->
        <div class="col-sm-12 col-md-12">
            <div class="card">
                <div class="card-body">
                    <h4 class="card-title">Feedbacks</h4>
                    <div class="table-responsive">

                        <asp:Repeater ID="rFeedback" runat="server" OnItemCommand="rFeedback_ItemCommand">
                            <HeaderTemplate>
                                <table class="table data-table-export table-hover nowrap">
                                    <thead>
                                        <tr>
                                            <th>#</th>
                                            <th class="table-plus">Name</th>
                                            <th>Email</th>
                                            <th>Subject</th>
                                            <th>Message</th>
                                            <th>Create Date</th>
                                            <th class="dataTable-nosort">Operations</th>
                                        </tr>
                                    </thead>

                                    <tbody>
                            </HeaderTemplate>

                            <ItemTemplate>

                                <tr>
                                    <td class="table-plus"><%# Eval("SrNo") %></td>
                                    <td>
                                        <%# Eval("Name") %>
                                    </td>
                                    <td>
                                        <%# Eval("Email") %>
                                    </td>

                                    <td><%# Eval("Subject") %></td>
                                    <td><%# Eval("Message") %></td>
                                    <td><%# Eval("CreateDate") %></td>

                                    <td>
                                        <asp:LinkButton ID="lbtnDeleteButton" runat="server" Text="Delete" CssClass="badge badge-danger" OnClientClick="return confirm('Are you sure You Want to Delete This Feedback')" CommandArgument='<%# Eval("ContactId") %>' CommandName="delete" CausesValidation="False">
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
        <!--Display Feedback-->
    </div>

</asp:Content>
