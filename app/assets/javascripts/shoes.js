/*# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/*/

$(document).ready(function() {
  $("#paid-for-field").on("click", function(event) {
    event.stopPropagation();
    if ($('#shoe_paid_for').prop("checked")) {
      $("#type-of-payment.hidden").removeClass("hidden");
    } else {
      $("#type-of-payment").addClass("hidden");
      // remove checked from both payment options
      $("#shoe_type_of_payment_card").prop( "checked", false );
      $("#shoe_type_of_payment_cash").prop( "checked", false );
    };
  });

  $(".search-by-date-checkbox").on("click", function(event) {
    event.stopPropagation();

    if ($('#search_options_received_date').prop("checked")) {
      $("#search-received-date-input.hidden").removeClass("hidden");
    } else {
      $("#search-received-date-input").addClass("hidden");
    };

    if ($('#search_options_due_date').prop("checked")) {
      $("#search-due-date-input.hidden").removeClass("hidden");
    } else {
      $("#search-due-date-input").addClass("hidden");
    };
  });
});
