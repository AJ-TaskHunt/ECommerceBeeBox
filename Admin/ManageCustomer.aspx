<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="ManageCustomer.aspx.cs" Inherits="ECommerceBeeBox.Admin.ManageCustomer" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <%--<style type="text/css">
        .password-container {
            position: relative;
        }

        .password-icon {
            position: absolute;
            right: 20px;
            top: 40%;
            transform: translateY(-50%);
            cursor: pointer;
            height: 19px;
        }
    </style>--%>

     <script>

       <%-- //for Password Icon
        function TogglePassword() {
            var passwordTextbox = $('#<%=txtPassword.ClientID %>');
            var passwordIcon = $('.password-icon');

            if (passwordTextbox.attr('type') === 'password') {
                passwordTextbox.attr('type', 'text');
                passwordIcon.attr('src', '../AdminTemplate/assets/images/users/eye-closed.png');
            } else if (passwordTextbox.attr('type') !== 'password') {
                passwordTextbox.attr('type', 'password');
                passwordIcon.attr('src', '../AdminTemplate/assets/images/users/eye-open.png'); 
            }
            else {
                passwordTextbox.attr('type', 'password');
                passwordIcon.attr('src', '../AdminTemplate/assets/images/users/eye-open.png'); 
            }
        }--%>


        //For disappearing alert message

        window.onload = function () {
            var second = 5;
            setTimeout(function () {
                document.getElementById("<%= lblmsg.ClientID %>").style.display = "none";
            }, second * 1000);
        };

    </script>

     <%-- <script>
        //for Image Preview
        function ImagePreview(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();

                reader.onload = function (e) {
                    $('#<%=imgCustomer.ClientID %>').prop('src', e.target.result)
                        .width(200)
                        .height(200);
                };
                reader.readAsDataURL(input.files[0]);
            }
        }

    </script>--%>


    <div class="mb-4">
        <asp:Label ID="lblmsg" runat="server"></asp:Label>
    </div>

    <div class="row">

        <!--Add or Update Customer-->
        <%-- <div class="col-sm-12 col-md-4">
            <div class="card">
                <div class="card-body">
                    <h4 class="card-title">Manage Customer</h4>
                    <hr />

                    <asp:HiddenField ID="hfCustomerId" runat="server" />

                    <div class="form-body" prompttext="Select SubCategory">--%>
        <%-- <label>Name</label>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="Name"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvName" runat="server" ForeColor="Red" Font-Size="Small" Display="Dynamic" SetFocusOnError="true" ControlToValidate="txtName" ErrorMessage="Name Required"> </asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </div>

                        <label>Email</label>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="Email"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ForeColor="Red" Font-Size="Small" Display="Dynamic" SetFocusOnError="true" ControlToValidate="txtEmail" ErrorMessage="Email Required"> </asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </div>

                        <label>Mobile</label>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <asp:TextBox ID="txtMobile" runat="server" CssClass="form-control" placeholder="Mobile"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvMobile" runat="server" ForeColor="Red" Font-Size="Small" Display="Dynamic" SetFocusOnError="true" ControlToValidate="txtMobile" ErrorMessage="Mobile Required"> </asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </div>--%>

        <%--  <label>Address</label>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" placeholder="Address" TextMode="MultiLine"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvAddress" runat="server" ForeColor="Red" Font-Size="Small" Display="Dynamic" SetFocusOnError="true" ControlToValidate="txtAddress" ErrorMessage="Address Required"> </asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </div>--%>

        <%--<label>Post Code</label>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <asp:TextBox ID="txtPostCode" runat="server" CssClass="form-control" placeholder="Enter Post Code"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvProductPrice" runat="server" ForeColor="Red" Font-Size="Small" Display="Dynamic" SetFocusOnError="true" ControlToValidate="txtPostCode" ErrorMessage="PostCode is Required"> </asp:RequiredFieldValidator>
                                    <%--<asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Price must be in decimal" ValidationExpression="^\d{0,8}(\.\d{1,4})?$" ForeColor="Red" Font-Size="Small" Display="Dynamic" SetFocusOnError="true" ControlToValidate="txtProductPrice"></asp:RegularExpressionValidator>--%>
        <%--           </div>
                            </div>
                        </div>--%>

                      <%--  <label>Password</label>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <asp:TextBox ID="txtPassIcon" runat="server" CssClass="form-control" placeholder="Password"></asp:TextBox>
                                    <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Password"></asp:TextBox>
                                    <img runat="server" id="PassIcon" src="../AdminTemplate/assets/images/users/eye-open.png" class="password-icon" onclick="TogglePassword()"/>
                                    <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ForeColor="Red" Font-Size="Small" Display="Dynamic" SetFocusOnError="true" ControlToValidate="txtPassword" ErrorMessage="Password is Required"> </asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </div>--%>

        <%-- <label>Profile Image</label>
                        <div class="form-group">
                            <asp:FileUpload ID="fuCustomerImage" runat="server" CssClass="form-control" onchange="ImagePreview(this);" accept=".png,.jpg,.jpeg" />
                            <asp:RegularExpressionValidator ID="regexImage" runat="server" ForeColor="Red" Font-Size="Small" Display="Dynamic" SetFocusOnError="true" ControlToValidate="fuCustomerImage" ValidationExpression="(.*?)\.(jpg|png|jpeg)$" ErrorMessage="Only .jpg .png .jpeg image file are allowed "></asp:RegularExpressionValidator>
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
                                <asp:Button ID="btnAdd" runat="server" CssClass="btn btn-info" Text="Add" OnClick="btnAdd_Click" />
                                <asp:Button ID="btnUpdate" Text="Update" runat="server" CssClass="btn btn-info" OnClick="btnUpdate_Click" />
                                <asp:Button ID="btnClear" runat="server" CssClass="btn btn-dark" Text="Reset" CausesValidation="false" OnClick="btnClear_Click" />
                            </div>
                        </div>--%>

        <%--<div>
                            <asp:Image ID="imgCustomer" runat="server" CssClass="img-thumbnail" />
                        </div>--%>

        <%--                    </div>
                </div>
            </div>
        </div>--%>
        <!--End Add or Update Customer-->

        <!--Display Customers-->
        <div class="col-sm-12 col-md-12">
            <div class="card">
                <div class="card-body">
                    <h4 class="card-title">Customer List</h4>
                    <div class="table-responsive">

                        <asp:Repeater ID="rCustomerData" runat="server" OnItemCommand="rCustomerData_ItemCommand">
                            <HeaderTemplate>
                                <table class="table data-table-export table-hover nowrap">
                                    <thead>
                                        <tr>
                                            <th class="table-plus">Name</th>
                                            <th>Image</th>
                                            <th>Address</th>
                                            <th>PostCode</th>
                                            <th>Mobile</th>
                                            <th>Email</th>
                                            <th>IsActive</th>
                                            <th>Create Date</th>
                                            <th class="dataTable-nosort">Operations</th>
                                        </tr>
                                    </thead>

                                    <tbody>
                            </HeaderTemplate>

                            <ItemTemplate>

                                <tr>
                                    <td class="table-plus"><%# Eval("Name") %></td>
                                    <td>
                                        <asp:Image ID="imgProduct" runat="server" ImageUrl='<%# Eval("ImageUrl") %>' Width="50px" Height="50px" />
                                    </td>
                                    <td><%# Eval("Address") %></td>
                                    <td><%# Eval("PostCode") %></td>
                                    <td><%# Eval("Mobile") %></td>
                                    <td><%# Eval("Email") %></td>
                                    <td>
                                        <asp:Label ID="lblIsActive" runat="server" Text='<%# (bool)Eval("IsActive") == true ? "Unblocked" : "Bloked" %>' CssClass='<%# (bool)Eval("IsActive") == true ? "badge badge-success" : "badge badge-danger" %>'></asp:Label>
                                    </td>

                                    <td><%# Eval("CreateDate") %></td>
                                    <td>
                                        <asp:LinkButton ID="lbtnUnBlock" runat="server" Text="Unblock" CssClass="badge badge-success" CommandArgument='<%# Eval("CustomerId") %>' CommandName="unblock" OnClientClick="return confirm('Are sure you want to Unblock this Customer')">
                                        </asp:LinkButton>
                                        &nbsp;&nbsp;
                                        <asp:LinkButton ID="lbtnBlock" runat="server" Text="Block" CssClass="badge badge-danger" CommandArgument='<%# Eval("CustomerId") %>' CommandName="block" OnClientClick="return confirm('Are sure you want to Block this Customer')">
                                        </asp:LinkButton>
                                        &nbsp;&nbsp;
                                        <asp:LinkButton ID="LinkButton1" runat="server" Text="Delete" CssClass="badge badge-danger" OnClientClick="return confirm('Are you sure You Want to Delete This Customer')" CommandArgument='<%# Eval("CustomerId") %>' CommandName="delete" CausesValidation="False">
                                        <i class="icon-trash"></i>
                                        </asp:LinkButton>
                                    </td>

                                    <%--<td>
                                        <asp:LinkButton ID="lbtnEditButton" runat="server" Text="Edit" CssClass="badge badge-primary" CommandArgument='<%# Eval("CustomerId") %>' CommandName="edit" CausesValidation="False">
                                         <i class="fas fa-edit"></i>
                                        </asp:LinkButton>
                                        &nbsp;&nbsp;&nbsp;&nbsp;
                                     <asp:LinkButton ID="lbtnBlock" runat="server" Text="Delete" CssClass="badge badge-danger" OnClientClick="return confirm('Are you sure You Want to Delete This Customer')" CommandArgument='<%# Eval("CustomerId") %>' CommandName="delete" CausesValidation="False">
                                         <i class="icon-trash"></i>
                                     </asp:LinkButton>

                                    </td>--%>
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
        <!--Display Customers-->
    </div>

</asp:Content>
