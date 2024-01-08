<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Category.aspx.cs" Inherits="ECommerceBeeBox.Admin.Category" %>

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

    <script>
        //for Image Preview
        function ImagePreview(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();

                reader.onload = function (e) {
                    $('#<%=imgCategory.ClientID %>').prop('src', e.target.result)
                        .width(200)
                        .height(200);
                };
                reader.readAsDataURL(input.files[0]);
            }
        }

    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="mb-4">
        <asp:Label ID="lblmsg" runat="server"></asp:Label>
    </div>

    <div class="row">

        <!--Add or Update Category-->
        <div class="col-sm-12 col-md-4">
            <div class="card">
                <div class="card-body">
                    <h4 class="card-title">Category</h4>
                    <hr />

                    <asp:HiddenField ID="hfCategoryId" runat="server" />

                    <div class="form-body">
                        <label>Category Name</label>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <asp:TextBox ID="txtCategoryname" runat="server" CssClass="form-control" placeholder="Enter Category Name"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvCategoryName" runat="server" ForeColor="Red" Font-Size="Small" Display="Dynamic" SetFocusOnError="true" ControlToValidate="txtCategoryname" ErrorMessage="Category Name Required"> </asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </div>

                        <label>Category Image</label>
                        <div class="form-group">
                            <asp:FileUpload ID="fuCatgeoryImage" runat="server" CssClass="form-control" onchange="ImagePreview(this);" accept=".png,.jpg,.jpeg" />
                            <asp:RegularExpressionValidator ID="regexImage" runat="server" ForeColor="Red" Font-Size="Small" Display="Dynamic" SetFocusOnError="true" ControlToValidate="fuCatgeoryImage" ValidationExpression="(.*?)\.(jpg|png|jpeg)$" ErrorMessage="Only .jpg .png .jpeg image file are allowed "></asp:RegularExpressionValidator>
                        </div>

                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <asp:CheckBox ID="cbIsActive" runat="server" Text="&nbsp;IsActive" />
                                </div>
                            </div>
                        </div>

                        <div class="form-action pb-5">
                            <div class="text-left">
                                <asp:Button ID="btnAdd" runat="server" CssClass="btn btn-info" Text="Add" OnClick="btnAddCategoryData_Click" />
                                <asp:Button ID="btnUpdate" Text="Update" runat="server" OnClick="btnUpdate_Click" CssClass="btn btn-info" />
                                <asp:Button ID="btnClear" runat="server" CssClass="btn btn-dark" Text="Reset" OnClick="btnClear_Click" />
                            </div>
                        </div>

                        <div>
                            <asp:Image ID="imgCategory" runat="server" CssClass="img-thumbnail" />
                        </div>

                    </div>
                </div>
            </div>
        </div>
        <!--End Add or Update Category-->

        <!--Display Category-->
        <div class="col-sm-12 col-md-8">
            <div class="card">
                <div class="card-body">
                    <h4 class="card-title">Categories List</h4>
                    <div class="table-responsive">

                        <asp:Repeater ID="rCategoryData" runat="server" OnItemCommand="rCategoryData_ItemCommand">
                            <HeaderTemplate>
                                <table class="table data-table-export table-hover nowrap">
                                    <thead>
                                        <tr>
                                            <th class="table-plus">Name</th>
                                            <th>Image</th>
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
                                    <td>
                                        <asp:Image ID="imgCategory" runat="server" ImageUrl='<%# Eval("ImageUrl") %>' Width="50" Height="50" />
                                    </td>
                                    <td>
                                        <asp:Label ID="lblIsActive" runat="server" Text='<%# (bool)Eval("IsActive") == true ? "Active" : "In-Active" %>' CssClass='<%# (bool)Eval("IsActive") == true ? "badge badge-success" : "badge badge-danger" %>'></asp:Label>
                                    </td>

                                    <td><%# Eval("CreateDate") %></td>

                                    <td>
                                        <asp:LinkButton ID="lbtnEditButton" runat="server" Text="Edit" CssClass="badge badge-primary" CommandArgument='<%# Eval("CategoryId") %>' CommandName="edit" CausesValidation="False">
                                            <i class="fas fa-edit"></i>
                                        </asp:LinkButton>
                                        &nbsp;&nbsp;&nbsp;&nbsp;
                                        <asp:LinkButton ID="lbtnDeleteButton" runat="server" Text="Delete" CssClass="badge badge-danger" OnClientClick="return confirm('Are you sure You Want to Delete This Category')" CommandArgument='<%# Eval("CategoryId") %>' CommandName="delete" CausesValidation="False">
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
        <!--Display Category-->
    </div>

</asp:Content>
