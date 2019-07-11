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

  $(".sort-by-date-checkbox").on("click", function(event) {
    event.stopPropagation();

    if ($('#sorting_options_received_date').prop("checked")) {
      $("#sort-received-date-input.hidden").removeClass("hidden");
    } else {
      $("#sort-received-date-input").addClass("hidden");
    };

    if ($('#sorting_options_due_date').prop("checked")) {
      $("#sort-due-date-input.hidden").removeClass("hidden");
    } else {
      $("#sort-due-date-input").addClass("hidden");
    };
  });
});
