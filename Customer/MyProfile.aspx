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

                                                <h3>My Order</h3>

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
