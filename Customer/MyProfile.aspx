<%@ Page Title="" Language="C#" MasterPageFile="~/Customer/Customer.Master" AutoEventWireup="true" CodeBehind="MyProfile.aspx.cs" Inherits="ECommerceBeeBox.Customer.MyProfile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

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

    <section class="book_section layout_padding">
        <div class="container">
            <div class="heading_container">
                <div class="align-self-lg-end">
                    <asp:Label ID="lblmsg" runat="server"></asp:Label>
                </div>
                <h3>My Profile</h3>
            </div>

            <div class-="row">
                <div class="col-12">
                    <div class="card">
                        <div class="card-body">
                            <div class="card-title mb-4">
                                <div class="d-flex justify-content-start">
                                    <div class="image-container">

                                        <asp:Image ID="imgProfile" runat="server" CssClass="img-thumbnail" Width="155" Height="152" />

                                        <div class="middle pt-2">
                                            <asp:LinkButton ID="lbtnEditDetails" runat="server" CssClass="btn btn-warning" OnClick="lbtnEditDetails_Click">
                                                <i class="fa fa-pencil"></i> Edit details
                                            </asp:LinkButton>

                                            <asp:LinkButton ID="lbtnUpdatePassword" runat="server" CssClass="btn btn-warning" OnClick="lbtnUpdatePassword_Click">
                                                <i class="fa fa-key"></i> Change Password
                                            </asp:LinkButton>
                                        </div>
                                    </div>

                                    <div class="userData ml-3">
                                        <h2 class="d-block" style="font-size: 1.5rem; font-weight: bold">
                                            <a href="javascript:void(0);"><%Response.Write(Session["CustomerUser"]); %></a>
                                        </h2>

                                        <%--<h6 class="d-block">
                                            <a href="javascript:void(0);">
                                                <asp:Label ID="lblAddress" runat="server" ToolTip="Address"></asp:Label>
                                            </a>
                                        </h6>--%>

                                        <h6 class="d-block">
                                            <a href="javascript:void(0);">
                                                <asp:Label ID="lblEmail" runat="server" ToolTip="Email"></asp:Label>
                                            </a>
                                        </h6>

                                        <h6 class="d-block">
                                            <a href="javascript:void(0);">
                                                <asp:Label ID="lblMobile" runat="server" ToolTip="Mobile"></asp:Label>
                                            </a>
                                        </h6>

                                        <%-- <h6 class="d-block">
                                            <a href="javascript:void(0);">
                                                <asp:Label ID="lblPostCode" runat="server" ToolTip="Post/Zip Code"></asp:Label>
                                            </a>
                                        </h6>--%>

                                        <h6 class="d-block">
                                            <a href="javascript:void(0);">
                                                <asp:Label ID="lblCreateDate" runat="server" ToolTip="Account Created Date"></asp:Label>
                                            </a>
                                        </h6>
                                    </div>

                                </div>
                            </div>

                            <div class="row">
                                <div class="col-12">
                                    <div>
                                        <ul class="nav nav-tabs mb-4" id="myTab" role="tablist">
                                            <li class="nav-item">
                                                <a class="nav-link active" id="basicInfo-tab" data-toggle="tab" href="#basicInfo" role="tab"
                                                    aria-controls="basicInfo" aria-selected="true">
                                                    <i class="fa fa-id-badge"></i>Basic Info
                                                </a>
                                            </li>
                                            <li class="nav-item">
                                                <a class="nav-link" id="connectedServices-tab" data-toggle="tab" href="#connectedServices"
                                                    role="tab" aria-controls="connectedServices" aria-selected="false">
                                                    <i class="fa fa-clock-o mr-2"></i>Purchased History
                                                </a>
                                            </li>
                                        </ul>

                                        <div class="tab-content ml-1" id="myTabContent">

                                            <%--Basic Customer Info--%>
                                            <div class="tab-pane fade show active" id="basicInfo" role="tabpanel" aria-labelledby="basicInfo-tab">
                                                <asp:Repeater ID="rCustomerBasicInfo" runat="server">
                                                    <ItemTemplate>

                                                        <div class="row">
                                                            <div class="col-sm-3 col-md-2 col-5">
                                                                <label style="font-weight: bold;">Full Name</label>
                                                            </div>
                                                            <div class="col-md-8 col-6">
                                                                <%# Eval("Name") %>
                                                            </div>
                                                        </div>
                                                        <hr />

                                                        <div class="row">
                                                            <div class="col-sm-3 col-md-2 col-5">
                                                                <label style="font-weight: bold;">Address</label>
                                                            </div>
                                                            <div class="col-md-8 col-6">
                                                                <%# Eval("Address") %>
                                                            </div>
                                                        </div>

                                                        <hr />
                                                        <div class="row">
                                                            <div class="col-sm-3 col-md-2 col-5">
                                                                <label style="font-weight: bold;">Email</label>
                                                            </div>
                                                            <div class="col-md-8 col-6">
                                                                <%# Eval("Email") %>
                                                            </div>
                                                        </div>
                                                        <hr />

                                                        <div class="row">
                                                            <div class="col-sm-3 col-md-2 col-5">
                                                                <label style="font-weight: bold;">Mobile</label>
                                                            </div>
                                                            <div class="col-md-8 col-6">
                                                                <%# Eval("Mobile") %>
                                                            </div>
                                                        </div>

                                                        <hr />
                                                        <div class="row">
                                                            <div class="col-sm-3 col-md-2 col-5">
                                                                <label style="font-weight: bold;">Post/Zip Code</label>
                                                            </div>
                                                            <div class="col-md-8 col-6">
                                                                <%# Eval("PostCode") %>
                                                            </div>
                                                        </div>
                                                    </ItemTemplate>

                                                </asp:Repeater>
                                            </div>
                                            <%--Basic Customer Info end--%>


                                            <%--Order Details--%>
                                            <div class="tab-pane fade" id="connectedServices" role="tabpanel"
                                                aria-labelledby="ConnectedServices-tab">
                                                <asp:Repeater ID="rPurchasedHistory" runat="server" OnItemDataBound="rPurchasedHistory_ItemDataBound">
                                                    <ItemTemplate>
                                                        <div class="container">
                                                            <div class="row pt-1 pb-1" style="background-color: lightgray;">
                                                                <div class="col-4">
                                                                    <span class="badge badge-pill badge-danger text-white">
                                                                        <%# Eval("#") %>
                                                                    </span>
                                                                    Payment Mode: 
                                    <%# Eval("PaymentMode").ToString() == "Card" ? Eval("PaymentMode").ToString().ToUpper() : "Cash On Delivery" %>
                                                                </div>
                                                                <div class="col-6 ">
                                                                    <%# Convert.ToInt64(Eval("CardNo")) == 0 ? "" : "Card No:"+ "************" + Convert.ToInt64( Eval("CardNo").ToString().Substring(Math.Max(0, Eval("CardNo").ToString().Length - 4))) %>
                                                                </div>
                                                                <div class="col-2">
                                                                    <a href="Invoice.aspx?pid=<%# Eval("PaymentId") %>"><i class="fa fa-download mr-2"></i>Invoice</a>
                                                                </div>
                                                            </div>

                                                            <asp:HiddenField ID="hfPaymentId" runat="server" Value='<%# Eval("PaymentId") %>' />

                                                            <asp:Repeater ID="rOrderDetails" runat="server">
                                                                <HeaderTemplate>
                                                                    <table class="table data-table-export table-responsive-sm table-bordered table-hover">
                                                                        <thead>
                                                                            <tr class="bg-dark text-white">
                                                                                <th>Product Name</th>
                                                                                <th>Price</th>
                                                                                <th>Quantity</th>
                                                                                <th>OrderId</th>
                                                                                <th>Total Price</th>
                                                                                <th>Status</th>
                                                                            </tr>
                                                                        </thead>
                                                                </HeaderTemplate>
                                                                <ItemTemplate>
                                                                    <tbody>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Label ID="lblProductName" runat="server" Text='<%# Eval("ProductName") %>'></asp:Label>
                                                                            </td>
                                                                            <td>
                                                                                <asp:Label ID="lblPrice" runat="server" Text=' <%# string.IsNullOrEmpty( Eval("Price").ToString() ) ? "" : "₹" + Eval("Price") %>'></asp:Label>
                                                                            </td>
                                                                            <td>
                                                                                <asp:Label ID="lblQty" runat="server" Text='<%# Eval("Quantity") %>'></asp:Label>
                                                                            </td>
                                                                            <td>
                                                                                <asp:Label ID="lblOrderId" runat="server" Text='<%# Eval("OrderNo") %>'></asp:Label>
                                                                            </td>
                                                                            <td>
                                                                                <asp:Label ID="lblTotal" runat="server" Text='<%# "₹" + Eval("TotalAmount") %>'></asp:Label>
                                                                            </td>
                                                                            <td>
                                                                                <asp:Label ID="lblStatus" runat="server" Text='<%# Eval("Status") %>'></asp:Label>
                                                                            </td>
                                                                        </tr>

                                                                </ItemTemplate>
                                                                <FooterTemplate>
                                                                    <tr>
                                                                        <td colspan="3"></td>
                                                                        <td>aaa</td>
                                                                    </tr>
                                                                    </tbody>
                                                                 </table>
                                                                </FooterTemplate>
                                                            </asp:Repeater>

                                                        </div>
                                                    </ItemTemplate>
                                                </asp:Repeater>

                                                <div class="text-center">
                                                    <asp:Label ID="lblOrder" runat="server" Visible="false" Text="No Order" CssClass="text-black-50"></asp:Label>
                                                </div>

                                            </div>
                                            <%--Order Details End--%>
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </section>

</asp:Content>
