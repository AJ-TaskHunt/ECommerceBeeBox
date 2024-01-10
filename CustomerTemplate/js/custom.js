// to get current year
function getYear() {
    var currentDate = new Date();
    var currentYear = currentDate.getFullYear();
    document.querySelector("#displayYear").innerHTML = currentYear;
}

getYear();


// isotope js
$(window).on('load', function () {
    $('.filters_menu li').click(function () {
        $('.filters_menu li').removeClass('active');
        $(this).addClass('active');

        var data = $(this).attr('data-filter');
        $grid.isotope({
            filter: data
        })
    });

    var $grid = $(".grid").isotope({
        itemSelector: ".all",
        percentPosition: false,
        masonry: {
            columnWidth: ".all"
        }
    })
});

// nice select
$(document).ready(function () {
    $('select').niceSelect();
});

///** google_map js **/
//function myMap() {
//    var mapProp = {
//        center: new google.maps.LatLng(40.712775, -74.005973),
//        zoom: 18,
//    };
//    var map = new google.maps.Map(document.getElementById("googleMap"), mapProp);
//}

// client section owl carousel
$(".client_owl-carousel").owlCarousel({
    loop: true,
    margin: 0,
    dots: false,
    nav: true,
    navText: [],
    autoplay: true,
    autoplayHoverPause: true,
    navText: [
        '<i class="fa fa-angle-left" aria-hidden="true"></i>',
        '<i class="fa fa-angle-right" aria-hidden="true"></i>'
    ],
    responsive: {
        0: {
            items: 1
        },
        768: {
            items: 2
        },
        1000: {
            items: 2
        }
    }
});

//Quantity changes code

(function ($) {
    // Wrap your code in a document ready function
    $(document).ready(function () {
        // Select each .pro-qty individually to handle multiple instances
        $('.pro-qty').each(function () {
            var $productQty = $(this);

            $productQty.on('click', '.qtybtn', function () {
                var $button = $(this);
                var $input = $button.siblings('input');
                var oldValue = parseFloat($input.val());

                if ($button.hasClass('inc')) {
                    if (oldValue >= 10) {
                        var newVal = oldValue;
                    } else {
                        var newVal = oldValue + 1;
                    }
                } else {
                    if (oldValue > 1) {
                        var newVal = oldValue - 1;
                    } else {
                        var newVal = 1;
                    }
                }

                $input.val(newVal);
            });
        });
    });
})(jQuery);
