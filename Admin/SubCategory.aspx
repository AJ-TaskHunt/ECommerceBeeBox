<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="SubCategory.aspx.cs" Inherits="ECommerceBeeBox.Admin.SubCategory" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

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

    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

    <div class="mb-4">
        <asp:Label ID="lblmsg" runat="server"></asp:Label>
    </div>

    <div class="row">

        <!--Add or Update SubCategory-->
        <div class="col-sm-12 col-md-4">
            <div class="card">
                <div class="card-body">
                    <h4 class="card-title">SubCategory</h4>
                    <hr />

                    <asp:HiddenField ID="hfSubCategoryId" runat="server" />

                    <div class="form-body">
                        <label>SubCategory Name</label>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <asp:TextBox ID="txtSubCategoryname" runat="server" CssClass="form-control" placeholder="Enter SubCategory Name"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvSubCategory" runat="server" ForeColor="Red" Font-Size="Small" Display="Dynamic" SetFocusOnError="true" ControlToValidate="txtSubCategoryname" ErrorMessage="SubCategory Name Required"> </asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </div>


                        <label>Category</label>
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="form-group">
                                            <asp:DropDownList ID="ddlCategoryName" runat="server" CssClass="form-control" AutoPostBack="true"></asp:DropDownList>
                                            <asp:RequiredFieldValidator ID="rfvCategoryName" runat="server" ForeColor="Red" Font-Size="Small" Display="Dynamic" SetFocusOnError="true" ControlToValidate="ddlCategoryName" ErrorMessage="Please select Category"> </asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                </div>
                            </ContentTemplate>
                        </asp:UpdatePanel>

                        <%--<label>SubCategory</label>
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <asp:DropDownList ID="ddlSubCategoryName" runat="server" CssClass="form-control">
                                            <asp:ListItem Value="0">Select SubCategory</asp:ListItem>
                                            <asp:ListItem>Action games</asp:ListItem>
                                            <asp:ListItem>Adventure games</asp:ListItem>
                                            <asp:ListItem>Fighting games</asp:ListItem>
                                            <asp:ListItem>Sports games</asp:ListItem>
                                            <asp:ListItem>Simulation games</asp:ListItem>
                                            <asp:ListItem>Shooter game</asp:ListItem>
                                            <asp:ListItem>Survival horror</asp:ListItem>
                                            <asp:ListItem>Wireless</asp:ListItem>
                                            <asp:ListItem>Wire</asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="rfvSubCategoryName" runat="server" ForeColor="Red" Font-Size="Small" Display="Dynamic" SetFocusOnError="true" ControlToValidate="ddlSubCategoryName" ErrorMessage="SubCategory Name Required"> </asp:RequiredFieldValidator>
                                    </div>
                                </div>
                            </div>--%>

                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <asp:CheckBox ID="cbIsActive" runat="server" Text="&nbsp;IsActive" />
                                </div>
                            </div>
                        </div>

                        <div class="form-action pb-5">
                            <div class="text-left">
                                <asp:Button ID="btnAddSubCategory" runat="server" CssClass="btn btn-info" Text="Add" OnClick="btnAddSubCategory_Click" />
                                <asp:Button ID="btnUpdateSubCategory" runat="server" CssClass="btn btn-info" Text="Update" OnClick="btnUpdateSubCategory_Click" />
                                <asp:Button ID="btnClear" runat="server" CssClass="btn btn-dark" Text="Reset" OnClick="btnClear_Click" />
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>

        <!--End Add or Update SubCategory-->

        <!--Display SubCategory-->
        <div class="col-sm-12 col-md-8">
            <div class="card">
                <div class="card-body">
                    <h4 class="card-title">SubCategories List</h4>
                    <div class="table-responsive">

                        <asp:Repeater ID="rSubCategoryData" runat="server" OnItemCommand="rSubCategoryData_ItemCommand">
                            <HeaderTemplate>
                                <table class="table data-table-export table-hover nowrap">
                                    <thead>
                                        <tr>
                                            <th class="table-plus">Category</th>
                                            <th>SubCategory</th>
                                            <th>IsActive</th>
                                            <th>Create Date</th>
                                            <th class="dataTable-nosort">Operations</th>
                                        </tr>
                                    </thead>

                                    <tbody>
                            </HeaderTemplate>

                            <ItemTemplate>

                                <tr>
                                    <td class="table-plus"><%# Eval("CategoryName") %></td>
                                    <td><%# Eval("SubCategoryName") %></td>
                                    <td>
                                        <asp:Label ID="lblIsActive" runat="server" Text='<%# (bool)Eval("IsActive") == true ? "Active" : "In-Active" %>' CssClass='<%# (bool)Eval("IsActive") == true ? "badge badge-success" : "badge badge-danger" %>'></asp:Label>
                                    </td>

                                    <td><%# Eval("CreateDate") %></td>

                                    <td>
                                        <asp:LinkButton ID="lbtnEditButton" runat="server" Text="Edit" CssClass="badge badge-primary" CommandArgument='<%# Eval("SubCategoryId") %>' CommandName="edit" CausesValidation="False">
                                     <i class="fas fa-edit"></i>
                                        </asp:LinkButton>
                                        &nbsp;&nbsp;&nbsp;&nbsp;
                                 <asp:LinkButton ID="lbtnDeleteButton" runat="server" Text="Delete" CssClass="badge badge-danger" OnClientClick="return confirm('Are you sure You Want to Delete This SubCategory')" CommandArgument='<%# Eval("SubCategoryId") %>' CommandName="delete" CausesValidation="False">
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
        <!--Display SubCategory-->
    </div>
</asp:Content>
