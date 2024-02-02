<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="ECommerceBeeBox.Admin.Dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../AdminTemplate/assets/style.css" rel="stylesheet" />

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="card-header">
        <h1>Dashboard</h1>
    </div>
    <hr />
    <div class="row">
        <!-- card1 start -->
        <div class="col-md-6 col-xl-3">
            <div class="card widget-card-1">
                <div class="card-block-small">
                    <i class="icofont icofont-game-console bg-c-blue card1-icon"></i>
                    <span class="text-c-blue f-w-600">Categories</span>
                    <h4><% Response.Write(Session["Category"]); %></h4>
                    <div>
                        <span class="f-left m-t-10 text-muted">
                            <i class="text-c-blue f-16 icofont icofont-eye-alt"></i>
                            <a href="Category.aspx">View</a>
                        </span>
                    </div>
                </div>
            </div>
        </div>
        <!-- card1 end -->
        <!-- card1 start -->
        <div class="col-md-6 col-xl-3">
            <div class="card widget-card-1">
                <div class="card-block-small">
                    <i class="icofont icofont-game-pad bg-c-pink card1-icon"></i>
                    <span class="text-c-pink f-w-600">Sub Categories</span>
                    <h4><% Response.Write(Session["SubCategory"]); %></h4>
                    <div>
                        <span class="f-left m-t-10 text-muted">
                            <i class="text-c-blue f-16 icofont icofont-eye-alt"></i>
                            <a href="SubCategory.aspx">View</a>
                        </span>
                    </div>
                </div>
            </div>
        </div>
        <!-- card1 end -->
        <!-- card1 start -->
        <div class="col-md-6 col-xl-3">
            <div class="card widget-card-1">
                <div class="card-block-small">
                    <i class="icofont icofont-game-control bg-c-green card1-icon"></i>
                    <span class="text-c-green f-w-600">Products</span>
                    <h4><% Response.Write(Session["Product"]); %></h4>
                    <div>
                        <span class="f-left m-t-10 text-muted">
                            <i class="text-c-blue f-16 icofont icofont-eye-alt"></i>
                            <a href="Product.aspx">View</a>
                        </span>
                    </div>
                </div>
            </div>
        </div>
        <!-- card1 end -->
        <!-- card1 start -->
        <div class="col-md-6 col-xl-3">
            <div class="card widget-card-1">
                <div class="card-block-small">
                    <i class="icofont icofont-user bg-c-yellow card1-icon"></i>
                    <span class="text-c-yellow f-w-600">Customers</span>
                    <h4>Total : <% Response.Write(Session["Customer"]);%></h4>
                    <div>
                        <span class="f-left m-t-10 text-muted">
                            <i class="text-c-blue f-16 icofont icofont-eye-alt"></i>
                            <a href="ManageCustomer.aspx">View</a>



                        </span>
                    </div>
                </div>
            </div>
        </div>
        <!-- card1 end -->

        <!-- card1 start -->
        <div class="col-md-6 col-xl-3">
            <div class="card widget-card-1">
                <div class="card-block-small">
                    <i class="icofont icofont-box bg-c-yellow card1-icon"></i>
                    <span class="text-c-yellow f-w-600">Total Orders</span>
                    <h4><% Response.Write(Session["TotalOrders"]);%></h4>
                    <div>
                        <span class="f-left m-t-10 text-muted">
                            <i class="text-c-blue f-16 icofont icofont-eye-alt"></i>
                            <a href="OrderStatus.aspx">View</a>
                        </span>
                    </div>
                </div>
            </div>
        </div>
        <!-- card1 end -->

        <!-- card1 start -->
        <div class="col-md-6 col-xl-3">
            <div class="card widget-card-1">
                <div class="card-block-small">
                    <i class="icofont icofont-anchor bg-c-yellow card1-icon"></i>
                    <span class="text-c-yellow f-w-600">Cancel Order</span>
                    <h4><% Response.Write(Session["CancelledOrders"]);%></h4>
                    <div>
                        <span class="f-left m-t-10 text-muted">
                            <i class="text-c-blue f-16 icofont icofont-eye-alt"></i>
                            <a href="OrderCancelStatus.aspx">View</a>
                        </span>
                    </div>
                </div>
            </div>
        </div>
        <!-- card1 end -->

        <!-- card1 start -->
        <div class="col-md-6 col-xl-3">
            <div class="card widget-card-1">
                <div class="card-block-small">
                    <i class="icofont icofont-book-alt bg-c-yellow card1-icon"></i>
                    <span class="text-c-yellow f-w-600">Customer Feedback</span>
                    <h4><% Response.Write(Session["CustomerFeedback"]);%></h4>
                    <div>
                        <span class="f-left m-t-10 text-muted">
                            <i class="text-c-blue f-16 icofont icofont-eye-alt"></i>
                            <a href="Feedback.aspx">View</a>
                        </span>
                    </div>
                </div>
            </div>
        </div>
        <!-- card1 end -->

        <!-- card1 start -->
        <div class="col-md-6 col-xl-3">
            <div class="card widget-card-1">
                <div class="card-block-small">
                    <i class="icofont icofont-offside bg-c-yellow card1-icon"></i>
                    <span class="text-c-yellow f-w-600">Blocked Customer</span>
                    <h4><% Response.Write(Session["Blocked_Customer"]);%></h4>
                    <div>
                        <span class="f-left m-t-10 text-muted">
                            <i class="text-c-blue f-16 icofont icofont-eye-alt"></i>
                            <a href="ManageCustomer.aspx">View</a>
                        </span>
                    </div>
                </div>
            </div>
        </div>
        <!-- card1 end -->

        <!-- card1 start -->
        <div class="col-md-6 col-xl-3">
            <div class="card widget-card-1">
                <div class="card-block-small">
                    <i class="icofont icofont-offside bg-c-yellow card1-icon"></i>
                    <span class="text-c-yellow f-w-600">Pending Order</span>
                    <h4><% Response.Write(Session["PendingOrders"]);%></h4>
                    <div>
                        <span class="f-left m-t-10 text-muted">
                            <i class="text-c-blue f-16 icofont icofont-eye-alt"></i>
                            <a href="OrderStatus.aspx">View</a>
                        </span>
                    </div>
                </div>
            </div>
        </div>
        <!-- card1 end -->

        <!-- card1 start -->
        <div class="col-md-6 col-xl-3">
            <div class="card widget-card-1">
                <div class="card-block-small">
                    <i class="icofont icofont-offside bg-c-yellow card1-icon"></i>
                    <span class="text-c-yellow f-w-600">Dispached Order</span>
                    <h4><% Response.Write(Session["DispatchedOrders"]);%></h4>
                    <div>
                        <span class="f-left m-t-10 text-muted">
                            <i class="text-c-blue f-16 icofont icofont-eye-alt"></i>
                            <a href="OrderStatus.aspx">View</a>
                        </span>
                    </div>
                </div>
            </div>
        </div>
        <!-- card1 end -->

        <!-- card1 start -->
        <div class="col-md-6 col-xl-3">
            <div class="card widget-card-1">
                <div class="card-block-small">
                    <i class="icofont icofont-offside bg-c-yellow card1-icon"></i>
                    <span class="text-c-yellow f-w-600">Delivered Order</span>
                    <h4><% Response.Write(Session["DeliveredOrders"]);%></h4>
                    <div>
                        <span class="f-left m-t-10 text-muted">
                            <i class="text-c-blue f-16 icofont icofont-eye-alt"></i>
                            <a href="OrderStatus.aspx">View</a>
                        </span>
                    </div>
                </div>
            </div>
        </div>
        <!-- card1 end -->

        <!-- card1 start -->
        <div class="col-md-6 col-xl-3">
            <div class="card widget-card-1">
                <div class="card-block-small">
                    <i class="icofont icofont-money-bag bg-c-yellow card1-icon"></i>
                    <span class="text-c-yellow f-w-600">Sold Amount</span>
                    <h4>₹<% Response.Write(Session["SoldAmount"]);%></h4>
                    <div>
                        <span class="f-left m-t-10 text-muted">
                            <i class="text-c-blue f-16 icofont icofont-eye-alt"></i>
                            <a href="Report.aspx">View</a>
                        </span>
                    </div>
                </div>
            </div>
        </div>
        <!-- card1 end -->
    </div>
</asp:Content>
