<%@ Page Title="" Language="C#" MasterPageFile="~/Customer/Customer.Master" AutoEventWireup="true" CodeBehind="Controller.aspx.cs" Inherits="ECommerceBeeBox.Customer.Controller" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

     <script>

     //alert box
     function showSweetAlert() {
         Swal.fire({
             title: 'To proceed, you must first login',
             text: 'Click OK to Login',
             icon: 'info',
             didOpen: () => {
                 // Select the element you want to remove and remove it
                 const niceSelectElement = document.querySelector('.nice-select swal2-select open');
                 const extraElement = document.querySelector('.nice-select swal2-select');

                 if (niceSelectElement || extraElement) {
                     niceSelectElement.remove();
                     extraElement.remove();
                 }
             }
         }).then(function (result) {
             if (result.isConfirmed) {
                 window.location.href = 'Login.aspx';
             }
         });
     }


     //alert box
     function CartItemExists() {
         Swal.fire({
             text: 'Item already exist',
             icon: 'info',
             didOpen: () => {
                 // Select the element you want to remove and remove it
                 const niceSelectElement = document.querySelector('.nice-select swal2-select open');
                 const extraElement = document.querySelector('.nice-select swal2-select');

                 if (niceSelectElement || extraElement) {
                     niceSelectElement.remove();
                     extraElement.remove();
                 }
             }
         });
     }

     //alert box
     function ItemAddedToCart() {
         Swal.fire("Your item has been added to your cart successfully!");
     }

     </script>

 <style>
     .swal2-select.nice-select {
         display: none !important;
     }

     .nice-select swal2-select open {
         display: none !important;
     }
 </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <!-- food section -->

    <section class="food_section layout_padding">
        <div class="container">
            <div class="heading_container heading_center">
                <h2>Controller Categories
                </h2>
            </div>

            <ul class="filters_menu">
                <li class="active" data-filter="*">All</li>
                <asp:Repeater ID="rControllerCategories" runat="server">
                    <ItemTemplate>
                        <li data-filter=".<%# Eval("SubCategoryName").ToString().ToLower().Replace(" ", "") %>">
                            <%# Eval("SubCategoryName") %>
                        </li>
                    </ItemTemplate>
                </asp:Repeater>
            </ul>

            <div class="text-center">
                <asp:Label ID="lblmsg" runat="server" Text="<h2>Currently, there are no games available.</h2>" CssClass="text-black-50"></asp:Label>
            </div>

            <!--Display Games Start -->
            <div class="row grid">
                <div class="filters-content">
                    <asp:Repeater ID="rController" runat="server" OnItemCommand="rController_ItemCommand">
                        <ItemTemplate>
                            <div class="col-sm-6 col-lg-4 all <%# Eval("SubCategoryName").ToString().ToLower().Replace(" ", "") %>">
                                <div class="box">
                                    <div>
                                        <div class="img-box">
                                            <asp:Image ID="imgProduct" runat="server" ImageUrl='<%# Eval("ProductImageUrl") %>' />
                                        </div>
                                        <div class="detail-box">
                                            <h5><%# Eval("ProductName") %> </h5>
                                            <p>
                                                <%# Eval("Description") %>
                                            </p>
                                            <div class="options">
                                                <h6>₹<%# Eval("Price") %> </h6>
                                                <asp:LinkButton ID="lbtnAddToCart" runat="server" CommandName="AddToCart" CommandArgument='<%# Eval("ProductId") %>'>
                                         <svg version="1.1" id="Capa_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" viewBox="0 0 456.029 456.029" style="enable-background: new 0 0 456.029 456.029;" xml:space="preserve">
                                             <g>
                                                 <g>
                                                     <path d="M345.6,338.862c-29.184,0-53.248,23.552-53.248,53.248c0,29.184,23.552,53.248,53.248,53.248
           c29.184,0,53.248-23.552,53.248-53.248C398.336,362.926,374.784,338.862,345.6,338.862z" />
                                                 </g>
                                             </g>
                                             <g>
                                                 <g>
                                                     <path d="M439.296,84.91c-1.024,0-2.56-0.512-4.096-0.512H112.64l-5.12-34.304C104.448,27.566,84.992,10.67,61.952,10.67H20.48
           C9.216,10.67,0,19.886,0,31.15c0,11.264,9.216,20.48,20.48,20.48h41.472c2.56,0,4.608,2.048,5.12,4.608l31.744,216.064
           c4.096,27.136,27.648,47.616,55.296,47.616h212.992c26.624,0,49.664-18.944,55.296-45.056l33.28-166.4
           C457.728,97.71,450.56,86.958,439.296,84.91z" />
                                                 </g>
                                             </g>
                                             <g>
                                                 <g>
                                                     <path d="M215.04,389.55c-1.024-28.16-24.576-50.688-52.736-50.688c-29.696,1.536-52.224,26.112-51.2,55.296
           c1.024,28.16,24.064,50.688,52.224,50.688h1.024C193.536,443.31,216.576,418.734,215.04,389.55z" />
                                                 </g>
                                             </g>
                                             <g>
                                             </g>
                                             <g>
                                             </g>
                                             <g>
                                             </g>
                                             <g>
                                             </g>
                                             <g>
                                             </g>
                                             <g>
                                             </g>
                                             <g>
                                             </g>
                                             <g>
                                             </g>
                                             <g>
                                             </g>
                                             <g>
                                             </g>
                                             <g>
                                             </g>
                                             <g>
                                             </g>
                                             <g>
                                             </g>
                                             <g>
                                             </g>
                                             <g>
                                             </g>
                                         </svg>
                                                </asp:LinkButton>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>
            <!--Display Games End -->

            <%--<div class="btn-box">
                <a href="">View More
                </a>
            </div>--%>
        </div>
    </section>

    <!-- end food section -->

</asp:Content>
