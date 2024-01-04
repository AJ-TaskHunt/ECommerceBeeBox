<%@ Page Title="" Language="C#" MasterPageFile="~/Seller/Seller.Master" AutoEventWireup="true" CodeBehind="Product.aspx.cs" Inherits="ECommerceBeeBox.Seller.Product" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script>

        //For disappearing alert message

        window.onload = function () {
            var second = 5;
            setTimeout(function () {
                document.getElementById("<%= lblmsg.ClientID %>").style.display = "none";
            }, second * 1000);
        };

        //for Image Preview
        function ImagePreview(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();

                reader.onload = function (e) {
                    $('#<%=imgProfile.ClientID %>').prop('src', e.target.result)
                        .width(200)
                        .height(200);
                };
                reader.readAsDataURL(input.files[0]);
            }
        }

    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

    <div class="mb-4">
        <asp:Label ID="lblmsg" runat="server"></asp:Label>
    </div>

    <div class="row">

        <!--Add or Update Product-->
        <div class="col-sm-12 col-md-4">
            <div class="card">
                <div class="card-body">
                    <h4 class="card-title">Product</h4>
                    <hr />

                    <asp:HiddenField ID="hfProductId" runat="server" />

                    <div class="form-body" prompttext="Select SubCategory">
                        <label>Product Name</label>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <asp:TextBox ID="txtProductName" runat="server" CssClass="form-control" placeholder="Enter Product Name"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvProductName" runat="server" ForeColor="Red" Font-Size="Small" Display="Dynamic" SetFocusOnError="true" ControlToValidate="txtProductName" ErrorMessage="Product Name Required"> </asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </div>

                        <label>Product Description</label>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <asp:TextBox ID="txtProductDescription" runat="server" CssClass="form-control" placeholder="Enter Product Description" TextMode="MultiLine"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvProductDesciption" runat="server" ForeColor="Red" Font-Size="Small" Display="Dynamic" SetFocusOnError="true" ControlToValidate="txtProductDescription" ErrorMessage="Description Required"> </asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </div>

                        <label>Product Price(₹)</label>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <asp:TextBox ID="txtProductPrice" runat="server" CssClass="form-control" placeholder="Enter Product Price"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvProductPrice" runat="server" ForeColor="Red" Font-Size="Small" Display="Dynamic" SetFocusOnError="true" ControlToValidate="txtProductPrice" ErrorMessage="Price is Required"> </asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Price must be in decimal" ValidationExpression="^\d{0,8}(\.\d{1,4})?$" ForeColor="Red" Font-Size="Small" Display="Dynamic" SetFocusOnError="true" ControlToValidate="txtProductPrice"></asp:RegularExpressionValidator>
                                </div>
                            </div>
                        </div>

                        <label>Product Quantity</label>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <asp:TextBox ID="txtProductQuantity" runat="server" CssClass="form-control" placeholder="Enter Product Quantity"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ForeColor="Red" Font-Size="Small" Display="Dynamic" SetFocusOnError="true" ControlToValidate="txtProductQuantity" ErrorMessage="Quantity is Required"> </asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ErrorMessage="Quantity must be non negative" ForeColor="Red" Font-Size="Small" Display="Dynamic" SetFocusOnError="true" ControlToValidate="txtProductQuantity" ValidationExpression="^([1-9]\d*|0)$"></asp:RegularExpressionValidator>
                                </div>
                            </div>
                        </div>


                        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                            <ContentTemplate>
                                <label>Category</label>
                                <div style="width: fit-content; height: fit-content; background-color: white; color: blue">
                                    <asp:Label ID="lblCategory" runat="server"></asp:Label>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="form-group">
                                            <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlCategory_SelectedIndexChanged"></asp:DropDownList>
                                            <asp:RequiredFieldValidator ID="rfvCategory" runat="server" ForeColor="Red" Font-Size="Small" Display="Dynamic" SetFocusOnError="true" ControlToValidate="ddlCategory" ErrorMessage="Please select Category"> </asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                </div>

                                <label>SubCategory</label>
                                <div style="width: fit-content; height: fit-content; background-color: white; color: blue">
                                    <asp:Label ID="lblSubCategory" runat="server"></asp:Label>
                                </div>


                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="form-group">
                                            <asp:DropDownList ID="ddlSubCategory" runat="server" CssClass="form-control" AutoPostBack="true"></asp:DropDownList>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ForeColor="Red" Font-Size="Small" Display="Dynamic" SetFocusOnError="true" ControlToValidate="ddlSubCategory" ErrorMessage="Please select SubCategory"> </asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                </div>

                            </ContentTemplate>
                        </asp:UpdatePanel>

                        <label>Product Image</label>
                        <div class="form-group">
                            <asp:FileUpload ID="fuProductImage" runat="server" CssClass="form-control" onchange="ImagePreview(this);" accept=".png,.jpg,.jpeg" />
                            <asp:RegularExpressionValidator ID="regexImage" runat="server" ForeColor="Red" Font-Size="Small" Display="Dynamic" SetFocusOnError="true" ControlToValidate="fuProductImage" ValidationExpression="(.*?)\.(jpg|png|jpeg)$" ErrorMessage="Only .jpg .png .jpeg image file are allowed "></asp:RegularExpressionValidator>
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
                                <asp:Button ID="btnClear" runat="server" CssClass="btn btn-dark" Text="Reset" OnClick="btnClear_Click" CausesValidation="false" />
                            </div>
                        </div>

                        <div>
                            <asp:Image ID="imgProfile" runat="server" CssClass="img-thumbnail" />
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

                        <asp:Repeater ID="rProductData" runat="server" OnItemCommand="rCategoryData_ItemCommand">
                            <HeaderTemplate>
                                <table class="table data-table-export table-hover nowrap">
                                    <thead>
                                        <tr>
                                            <th class="table-plus">Product Name</th>
                                            <th>Image</th>
                                            <th>Description</th>
                                            <th>Price</th>
                                            <th>Quantity</th>
                                            <th>Category</th>
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
                                    <td class="table-plus"><%# Eval("ProductName") %></td>
                                    <td>
                                        <asp:Image ID="imgProduct" runat="server" ImageUrl='<%# Eval("ProductImageUrl" , "~/SellerTemplate/ProductImage/{0}") %>' Width="40px" Height="40px" />
                                    </td>
                                    <td><%# Eval("Description") %></td>
                                    <td><%# Eval("Price") %></td>
                                    <td><%# Eval("Quantity") %></td>
                                    <td><%# Eval("CategoryName") %></td>
                                    <td><%# Eval("SubCategoryName") %></td>
                                    <td>
                                        <asp:Label ID="lblIsActive" runat="server" Text='<%# (bool)Eval("IsActive") == true ? "Active" : "In-Active" %>' CssClass='<%# (bool)Eval("IsActive") == true ? "badge badge-success" : "badge badge-danger" %>'></asp:Label>
                                    </td>

                                    <td><%# Eval("CreateDate") %></td>

                                    <td>
                                        <asp:LinkButton ID="lbtnEditButton" runat="server" Text="Edit" CssClass="badge badge-primary" CommandArgument='<%# Eval("ProductId") %>' CommandName="edit" CausesValidation="False">
                                     <i class="fas fa-edit"></i>
                                        </asp:LinkButton>
                                        &nbsp;&nbsp;&nbsp;&nbsp;
                                 <asp:LinkButton ID="lbtnDeleteButton" runat="server" Text="Delete" CssClass="badge badge-danger" OnClientClick="return confirm('Are you sure You Want to Delete This Category')" CommandArgument='<%# Eval("ProductId") %>' CommandName="delete" CausesValidation="False">
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
