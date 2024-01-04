<%@ Page Title="" Language="C#" MasterPageFile="~/Customer/Customer.Master" AutoEventWireup="true" CodeBehind="Registration.aspx.cs" Inherits="ECommerceBeeBox.Customer.Registration" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <section class="book_section layout_padding">
        <div class="container">
            <div class="heading_container">
                <div class="align-self-lg-end">
                    <asp:Label ID="lblmsg" runat="server"></asp:Label>
                </div>
                <asp:Label ID="lblHeading" runat="server" Text="<h4>Customer Registration</h4>"></asp:Label>
            </div>
            <div class="row">
                <div class="col-md-6">
                    <div class="form_container">

                        <div>
                            <asp:RequiredFieldValidator ID="rfvName" runat="server" ErrorMessage="Name is Required" ControlToValidate="txtName" SetFocusOnError="true" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                            <asp:TextBox ID="txtName" runat="server" placeholder="Enter Full Name" CssClass="form-control" ToolTip="Full Name"></asp:TextBox>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Name Must be in character only" ValidationExpression="^[a-zA-Z\s]+$" ControlToValidate="txtName" ForeColor="Red" SetFocusOnError="true" Display="Dynamic"></asp:RegularExpressionValidator>
                        </div>

                        <div>
                            <asp:RequiredFieldValidator ID="rgvEmail" runat="server" ErrorMessage="Email is Required" ControlToValidate="txtEmail" SetFocusOnError="true" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                            <asp:TextBox ID="txtEmail" runat="server" placeholder="Enter Email" CssClass="form-control" ToolTip="Email"></asp:TextBox>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ErrorMessage="Please enter a valid Email" ValidationExpression="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$" ControlToValidate="txtEmail" ForeColor="Red" SetFocusOnError="true" Display="Dynamic"></asp:RegularExpressionValidator>
                        </div>

                        <div>
                            <asp:RequiredFieldValidator ID="rfvMobile" runat="server" ErrorMessage="Mobile Number is Required" ControlToValidate="txtMobile" SetFocusOnError="true" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                            <asp:TextBox ID="txtMobile" runat="server" placeholder="Enter Mobile Number" CssClass="form-control" ToolTip="Mobile Number"></asp:TextBox>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ErrorMessage="10 digits only" ValidationExpression="^\d{10}$" ControlToValidate="txtMobile" ForeColor="Red" SetFocusOnError="true" Display="Dynamic"></asp:RegularExpressionValidator>
                        </div>

                    </div>
                </div>


                <div class="col-md-6">
                    <div class="form_container">

                        <div>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Address is Required" ControlToValidate="txtAddress" SetFocusOnError="true" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                            <asp:TextBox ID="txtAddress" runat="server" TextMode="MultiLine" placeholder="Enter Address" CssClass="form-control" ToolTip="Address"></asp:TextBox>
                            
                        </div>

                        <div>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Post/Zip Code is Required" ControlToValidate="txtPostCode" SetFocusOnError="true" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                            <asp:TextBox ID="txtPostCode" runat="server" TextMode="Number" placeholder="Enter Post/Zip Code" CssClass="form-control" ToolTip="Post/Zip Code"></asp:TextBox>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator5" runat="server" ErrorMessage="Please enter a valid Post/Zip Code" ValidationExpression="^[0-9]{6}$" ControlToValidate="txtPostCode" ForeColor="Red" SetFocusOnError="true" Display="Dynamic"></asp:RegularExpressionValidator>
                        </div>

                        <div>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Mobile Number is Required" ControlToValidate="txtMobile" SetFocusOnError="true" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                            <asp:TextBox ID="TextBox3" runat="server" placeholder="Enter Mobile Number" CssClass="form-control" ToolTip="Mobile Number"></asp:TextBox>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator6" runat="server" ErrorMessage="10 digits only" ValidationExpression="^\d{10}$" ControlToValidate="txtMobile" ForeColor="Red" SetFocusOnError="true" Display="Dynamic"></asp:RegularExpressionValidator>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </section>


</asp:Content>
