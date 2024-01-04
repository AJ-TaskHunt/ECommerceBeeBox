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
