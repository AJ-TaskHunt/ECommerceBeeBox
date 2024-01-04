<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="ECommerceBeeBox.Seller.Register" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8">
    <title>Seller Registration</title>
    <link rel='stylesheet' href='https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css'>
    <link rel='stylesheet' href='https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.0.3/css/font-awesome.css'>
    <link rel="stylesheet" href="../SellerTemplate/assets/extra-libs/c3/MultiSteps.css">

    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <!-- Include jQuery Validation Plugin -->
    <script src="https://cdn.jsdelivr.net/jquery.validation/1.16.0/jquery.validate.min.js"></script>


    <style type="text/css">
        .auto-style1 {
            border-style: none;
            border-color: inherit;
            border-width: 0;
            background: skyblue;
            font-weight: bold;
            color: white;
            border-radius: 0px;
            cursor: pointer;
            padding: 10px 5px;
            margin: 10px 5px;
        }

        .error {
            color: red;
            font-weight: bold;
            font-size: small;
        }
    </style>
</head>
<body>

    <form id="msform" runat="server">

        <asp:ScriptManager runat="server"></asp:ScriptManager>

        <script type="text/javascript">

            //For disappearing alert message
            window.onload = function () {
                var second = 3;
                setTimeout(function () {
                    document.getElementById("<%= lblmsg.ClientID %>").style.display = "none";
                }, second * 1000);
            };

            //forName
            $(document).ready(function () {

                $('#<%= txtFullName.ClientID %>').on('keyup', function () {
                    var textBoxValue = $(this).val();
                    $('#<%= lblName.ClientID %>').text(textBoxValue);
                });
            });

            //forEmail
            $(document).ready(function () {
                $('#<%= txtEmail.ClientID %>').on('keyup', function () {
                    var textBoxValue = $(this).val();
                    $('#<%= lblMail.ClientID %>').text(textBoxValue);
                });
            });

            //forMobile
            $(document).ready(function () {
                $('#<%= txtMobile.ClientID %>').on('keyup', function () {
                    var textBoxValue = $(this).val();
                    $('#<%= lblMobile.ClientID %>').text(textBoxValue);
                });
            });

            //forAddress
            $(document).ready(function () {
                $('#<%= txtAddress.ClientID %>').on('keyup', function () {
                    var textBoxValue = $(this).val();
                    $('#<%= lblAddress.ClientID %>').text(textBoxValue);
                });
            });

            //forBankName
            $(document).ready(function () {
                $('#<%= txtBankName.ClientID %>').on('keyup', function () {
                    var textBoxValue = $(this).val();
                    $('#<%= lblBankName.ClientID %>').text(textBoxValue);
                });
            });

            //forAccountNumber
            $(document).ready(function () {
                $('#<%= txtAccountNumber.ClientID %>').on('keyup', function () {
                    var textBoxValue = $(this).val();
                    $('#<%= lblAccountNumber.ClientID %>').text(textBoxValue);
                });
            });

            //forGST-NUmber
            $(document).ready(function () {
                $('#<%= txtGSTNumber.ClientID %>').on('keyup', function () {
                    var textBoxValue = $(this).val();
                    $('#<%= lblGST.ClientID %>').text(textBoxValue);
                });
            });

            //forPAN-Number
            $(document).ready(function () {
                $('#<%= txtPANNumber.ClientID %>').on('keyup', function () {
                    var textBoxValue = $(this).val();
                    $('#<%= lblPAN.ClientID %>').text(textBoxValue);
                });
            });


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

        <script type="text/javascript">

            //for Name
            function Name() {
                var name = document.getElementById('<%= txtFullName.ClientID %>');
                var spanname = document.getElementById('txtNameError');
                var regex1 = /^[a-zA-Z\s]*$/;

                // Check if the Name is not empty
                if (name.value.trim() === '' || !regex1.test(name.value)) {
                    spanname.innerText = 'Please enter a valid Name';
                } else {
                    spanname.innerText = '';
                }

            }

            //for Email
            function Email() {

                var email = document.getElementById('<%= txtEmail.ClientID %>');
                var spmalEmail = document.getElementById('emailError');
                var regex2 = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;

                // Check if the Email is not empty
                if (email.value.trim() === '' || !regex2.test(email.value)) {
                    spmalEmail.innerText = 'Please enter a valid Email';
                } else {
                    spmalEmail.innerText = '';
                }
            }

            //for Address
            function Address() {

                var Address = document.getElementById('<%= txtAddress.ClientID %>');
                var spanAddress = document.getElementById('AddressError');
                var regex4 = /^[a-zA-Z0-9\s.,#-]+$/;

                // Check if the Address is not empty
                if (Address.value.trim() === '' || !regex4.test(Address.value)) {
                    spanAddress.innerText = 'Please enter a Address name';
                } else {
                    spanAddress.innerText = '';
                }
            }

            //for Mobile
            function Mobile() {

                var mobile = document.getElementById('<%= txtMobile.ClientID %>');
                var spanMobile = document.getElementById('MobileError');
                var regex3 = /^\d{10}$/;


                // Check if the Mobile is not empty
                if (mobile.value.trim() === '' || !regex3.test(mobile.value)) {
                    spanMobile.innerText = 'Please enter a valid Mobile';
                } else {
                    spanMobile.innerText = '';
                }
            }

            //for AccountNumber
            function AccountNumber() {

                var AccountNumber = document.getElementById('<%= txtAccountNumber.ClientID %>');
                var spanAccount = document.getElementById('AccoutnNumber');
                var regex6 = /^\d{15}$/;

                // Check if the AccountNumber is not empty
                if (AccountNumber.value.trim() === '' || !regex6.test(AccountNumber.value)) {
                    spanAccount.innerText = 'Invalid bank account number';
                } else {
                    spanAccount.innerText = '';
                }
            }

            //for GST
            function GST() {

                var GST = document.getElementById('<%= txtGSTNumber.ClientID %>');
                var spanGST = document.getElementById('GSTError');
                var regex7 = /^[A-Za-z0-9]{15}$/;


                // Check if the GST is not empty
                if (GST.value.trim() === '' || !regex7.test(GST.value)) {
                    spanGST.innerText = 'Please enter a valid GST number';
                } else {
                    spanGST.innerText = '';
                }
            }

            //for PAN
            function PAN() {

                var PAN = document.getElementById('<%= txtPANNumber.ClientID %>');
                var spanPAN = document.getElementById('PANError');
                var regex8 = /^[A-Z0-9]{10}$/;

                // Check if the PAN is not empty
                if (PAN.value.trim() === '' || !regex8.test(PAN.value)) {
                    spanPAN.innerText = 'Please enter a valid PAN number';
                } else {
                    spanPAN.innerText = '';
                }

            }

            //for Password
            function Password() {
                var pass = document.getElementById('<%= txtPassword.ClientID %>');
                var pass2 = document.getElementById('<%= txtConfirmPassword.ClientID %>');
                var SpanPassword = document.getElementById('passError');
                var regex9 = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/;

                // Check if the Password is not empty and meets the requirements
                if (pass.value.trim() === '' || !regex9.test(pass.value)) {
                    SpanPassword.innerText = 'Please enter a valid password';
                }
                else {
                    SpanPassword.innerText = '';
                }

                if (pass2.value.trim() === '' || !regex9.test(pass2.value)) {
                    SpanPassword.innerText = 'Please enter a valid password';
                }
                else {
                    SpanPassword.innerText = '';
                }

                // Check if the Confirm Password is not empty and matches the Password
                //if (pass2.value.trim() === '' || pass2.value !== pass.value) {
                //    SpanPassword.innerText = 'Password does not match';
                //} else {
                //    SpanPassword.innerText = ''; // Reset the error message
                //}
            }


            //for BankName
            function BankName() {

                var BankName = document.getElementById('<%= txtBankName.ClientID %>');
                var spanBankName = document.getElementById('BankNameError');
                var regex5 = /^[a-zA-Z\s]+$/;

                // Check if the BankName is not empty
                if (BankName.value.trim() === '' || !regex5.test(BankName.value)) {
                    spanBankName.innerText = 'Please enter a Bank name';
                } else {
                    spanBankName.innerText = '';
                }
            }
        </script>


        <!--Validation for Button Click -->
        <script type="text/javascript">

            $(document).ready(function () {

                function validateStep1() {
                    // Validate Name
                    var name = $('#<%= txtFullName.ClientID %>');
                    var spanname = $('#txtNameError');
                    var regex1 = /^[a-zA-Z\s]*$/;

                    if (name.val().trim() === '' || !regex1.test(name.val())) {
                        spanname.text('Please enter a valid Name');
                        return false; // Validation failed
                    } else {
                        spanname.text('');
                    }

                    // Validate Address
                    var Address = $('#<%= txtAddress.ClientID %>');
                    var spanAddress = $('#AddressError');
                    var regex4 = /^[a-zA-Z0-9\s.,#-]+$/;

                    if (Address.val().trim() === '' || !regex4.test(Address.val())) {
                        spanAddress.text('Please enter a valid Address');
                        return false; // Validation failed
                    } else {
                        spanAddress.text('');
                    }

                    // Validate Email
                    var email = $('#<%= txtEmail.ClientID %>');
                    var spmalEmail = $('#emailError');
                    var regex2 = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;

                    if (email.val().trim() === '' || !regex2.test(email.val())) {
                        spmalEmail.text('Please enter a valid Email');
                        return false; // Validation failed
                    } else {
                        spmalEmail.text('');
                    }

                    //Validate BankName
                    var BankName = document.getElementById('<%= txtBankName.ClientID %>');
                    var spanBankName = document.getElementById('BankNameError');
                    var regex5 = /^[a-zA-Z\s]+$/;

                    // Check if the BankName is not empty
                    if (BankName.value.trim() === '' || !regex5.test(BankName.value)) {
                        spanBankName.innerText = 'Please enter a Bank name';
                    } else {
                        spanBankName.innerText = '';
                    }

                    //validate Account Number
                    var AccountNumber = document.getElementById('<%= txtAccountNumber.ClientID %>');
                    var spanAccount = document.getElementById('AccoutnNumber');
                    var regex6 = /^\d{15}$/;

                    // Check if the AccountNumber is not empty
                    if (AccountNumber.value.trim() === '' || !regex6.test(AccountNumber.value)) {
                        spanAccount.innerText = 'Invalid bank account number';
                    } else {
                        spanAccount.innerText = '';
                    }

                    //Validate Mobile
                    var mobile = document.getElementById('<%= txtMobile.ClientID %>');
                    var spanMobile = document.getElementById('MobileError');
                    var regex3 = /^\d{10}$/;


                    // Check if the Mobile is not empty
                    if (mobile.value.trim() === '' || !regex3.test(mobile.value)) {
                        spanMobile.innerText = 'Please enter a valid Mobile';
                    } else {
                        spanMobile.innerText = '';
                    }

                    //Validate GST
                    var GST = document.getElementById('<%= txtGSTNumber.ClientID %>');
                    var spanGST = document.getElementById('GSTError');
                    var regex7 = /^[A-Za-z0-9]{15}$/;

                    // Check if the GST is not empty
                    if (GST.value.trim() === '' || !regex7.test(GST.value)) {
                        spanGST.innerText = 'Please enter a valid GST number';
                    } else {
                        spanGST.innerText = '';
                    }

                    //Validate PAN
                    var PAN = document.getElementById('<%= txtPANNumber.ClientID %>');
                    var spanPAN = document.getElementById('PANError');
                    var regex8 = /^[A-Z0-9]{10}$/
                        ;

                    // Check if the PAN is not empty
                    if (PAN.value.trim() === '' || !regex8.test(PAN.value)) {
                        spanPAN.innerText = 'Please enter a valid PAN number';
                    } else {
                        spanPAN.innerText = '';
                    }

                    // If all validations pass, you can proceed to the next step
                    return true;
                }

                $(".next").click(function () {
                    // Validate before proceeding to the next step
                    if (validateStep1()) {
                        var current_fs = $(this).parent();
                        var next_fs = $(this).parent().next();

                        // Add Class Active
                        $("#progressbar li").eq($("fieldset:visible").index(next_fs)).addClass("active");

                        // Show the next fieldset
                        next_fs.show();
                        // Hide the current fieldset with style
                        current_fs.animate({ opacity: 0 }, {
                            step: function (now) {
                                // For making fieldset appear animation
                                var opacity = 1 - now;

                                current_fs.css({
                                    'display': 'none',
                                    'position': 'relative'
                                });
                                next_fs.css({ 'opacity': opacity });
                            },
                            duration: 600
                        });
                    }
                });

                $(".previous").click(function () {
                    var current_fs = $(this).parent();
                    var previous_fs = $(this).parent().prev();

                    // Remove class active
                    $("#progressbar li").eq($("fieldset:visible").index(current_fs)).removeClass("active");

                    // Show the previous fieldset
                    previous_fs.show();

                    // Hide the current fieldset with style
                    current_fs.animate({ opacity: 0 }, {
                        step: function (now) {
                            // For making fieldset appear animation
                            var opacity = 1 - now;

                            current_fs.css({
                                'display': 'none',
                                'position': 'relative'
                            });
                            previous_fs.css({ 'opacity': opacity });
                        },
                        duration: 600
                    });
                });

            });


        </script>

        <!-- =============================================================================================================================== -->

        <!-- MultiStep Form -->
        <div class="container-fluid" id="grad1">
            <div class="row justify-content-center mt-0">
                <div class="col-11 col-sm-9 col-md-7 col-lg-6 text-center p-0 mt-3 mb-2">
                    <div class="card px-0 pt-4 pb-0 mt-3 mb-3">
                        <h2><strong>Sign Up Your User Account</strong></h2>
                        <p>Fill all form field to go to next step</p>
                        <div class="row">
                            <div class="col-md-12 mx-0">

                                <!-- progressbar -->
                                <ul id="progressbar">
                                    <li class="active" id="account"><strong>Personal</strong></li>
                                    <li id="personal"><strong>Account</strong></li>
                                    <li id="payment"><strong>Other</strong></li>
                                    <li id="confirm"><strong>Review</strong></li>
                                </ul>
                                <!-- fieldsets -->
                                <fieldset>
                                    <div class="form-card">
                                        <h2 class="fs-title">Personal Information</h2>
                                        <asp:TextBox ID="txtFullName" runat="server" placeholder="Full Name" onkeyup="Name()" ClientIDMode="Static"></asp:TextBox>
                                        <span id="txtNameError" class="error"></span>
                                        <br />
                                        <asp:TextBox ID="txtAddress" runat="server" placeholder="Address" onkeyup="Address()" ClientIDMode="Static" TextMode="MultiLine"></asp:TextBox>
                                        <span id="AddressError" class="error"></span>
                                        <br>
                                        <asp:TextBox ID="txtEmail" runat="server" placeholder="Email" onkeyup="Email()" ClientIDMode="Static"></asp:TextBox>
                                        <span id="emailError" class="error"></span>
                                        <asp:FileUpload ID="fuSellerImg" runat="server" onchange="ImagePreview(this);" />
                                    </div>
                                    <input type="button" name="next" class="next action-button" value="Next Step" />
                                </fieldset>
                                <fieldset>
                                    <div class="form-card">
                                        <h2 class="fs-title">Account Information</h2>
                                        <asp:TextBox ID="txtBankName" runat="server" placeholder="Bank Name" onkeyup="BankName()" ClientIDMode="Static"></asp:TextBox>
                                        <span id="BankNameError" class="error"></span>

                                        <asp:TextBox ID="txtAccountNumber" runat="server" placeholder="Bank Account Number" onkeyup="AccountNumber()" ClientIDMode="Static"></asp:TextBox>
                                        <span id="AccoutnNumber" class="error"></span>

                                        <asp:TextBox ID="txtMobile" runat="server" placeholder="Contact No." onkeyup="Mobile()" ClientIDMode="Static"></asp:TextBox>
                                        <span id="MobileError" class="error"></span>

                                    </div>
                                    <input type="button" name="previous" class="previous action-button-previous" value="Previous" />
                                    <input type="button" name="next" class="next action-button" value="Next Step" />
                                </fieldset>
                                <fieldset>
                                    <div class="form-card">
                                        <h2 class="fs-title">Other Information</h2>
                                        <asp:TextBox ID="txtGSTNumber" runat="server" placeholder="GST Number" onkeyup="GST()" ClientIDMode="Static"></asp:TextBox>
                                        <span id="GSTError" class="error"></span>

                                        <asp:TextBox ID="txtPANNumber" runat="server" placeholder="PAN Card Number" onkeyup="PAN()" ClientIDMode="Static"></asp:TextBox>
                                        <span id="PANError" class="error"></span>


                                    </div>
                                    <input type="button" name="previous" class="previous action-button-previous" value="Previous" />
                                    <input type="button" name="next" class="next action-button" value="Next" />

                                </fieldset>
                                <fieldset>
                                    <div class="form-card">
                                        <h2 class="fs-title text-center">Review</h2>
                                        <table class="table table-striped">
                                            <tr>
                                                <td>Name</td>
                                                <td>
                                                    <asp:Label ID="lblName" runat="server"></asp:Label>

                                                </td>
                                            </tr>

                                            <tr>
                                                <td>Address</td>
                                                <td>
                                                    <asp:Label ID="lblAddress" runat="server"></asp:Label>

                                                </td>
                                            </tr>

                                            <tr>
                                                <td>Email</td>
                                                <td>
                                                    <asp:Label ID="lblMail" runat="server"></asp:Label></td>
                                            </tr>

                                            <tr>
                                                <td>Image</td>
                                                <td>
                                                    <asp:Image ID="imgProfile" runat="server" Width="30px" Height="30px" />
                                                </td>
                                            </tr>

                                            <tr>
                                                <td>Bank Name</td>
                                                <td>
                                                    <asp:Label ID="lblBankName" runat="server"></asp:Label></td>
                                            </tr>

                                            <tr>
                                                <td>Bank Account Number</td>
                                                <td>
                                                    <asp:Label ID="lblAccountNumber" runat="server"></asp:Label>

                                                </td>
                                            </tr>

                                            <tr>
                                                <td>Contact No.</td>
                                                <td>
                                                    <asp:Label ID="lblMobile" runat="server"></asp:Label></td>
                                            </tr>

                                            <tr>
                                                <td>GST Number</td>
                                                <td>
                                                    <asp:Label ID="lblGST" runat="server"></asp:Label>
                                                </td>
                                            </tr>

                                            <tr>
                                                <td>PAN Number</td>
                                                <td>
                                                    <asp:Label ID="lblPAN" runat="server"></asp:Label>
                                                </td>
                                            </tr>

                                        </table>

                                        <span>
                                            <ajaxtoolkit:passwordstrength id="PasswordStrength1" runat="server" targetcontrolid="txtPassword" />
                                        </span>
                                        <asp:TextBox ID="txtPassword" runat="server" placeholder="Password" TextMode="Password" onkeyup="Password()" ClientIDMode="Static">
                                        </asp:TextBox>
                                        <asp:TextBox ID="txtConfirmPassword" runat="server" placeholder="Confirm Password" TextMode="Password">
                                        </asp:TextBox>
                                        <span>
                                            <ajaxtoolkit:passwordstrength id="PasswordStrength3" runat="server" targetcontrolid="txtConfirmPassword" />
                                        </span>

                                        <span id="passError" class="error"></span>


                                    </div>

                                    <input type="button" name="previous" class="previous action-button-previous" value="Previous" />


                                    <asp:Button ID="btnSignUp" Width="100px" Height="49px" runat="server" CssClass="auto-style1" Text="Sing Up" OnClick="btnSignUp_Click" ForeColor="White" />

                                    <asp:Label ID="lblmsg" runat="server"></asp:Label>

                                </fieldset>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </form>

    <!-- partial -->
    <script src='https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js'></script>
    <%--    <script src="../SellerTemplate/assets/extra-libs/c3/MultiSteps.js"></script>--%>
</body>
</html>
