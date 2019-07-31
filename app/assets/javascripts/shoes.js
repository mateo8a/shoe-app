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

  $(".search-option-checkbox").on("click", function(event) {
    event.stopPropagation();

    switch(event.target.id) {
      case "search_options_date_received":
        toggleDateReceivedOptions();
        break;
      case "search_options_date_due":
        toggleDateDueOptions();
        break;
      case "search_options_search_by_type_of_payment":
        toggleTypeOfPaymentOptions();
        break;
      case "search_options_search_by_paid_for":
        togglePaidForOptions();
        break;
    }
  });

  toggleDateReceivedOptions = function() {
    if ($('#search_options_date_received').prop("checked")) {
      $("#search-date-received-input.hidden").removeClass("hidden");
    } else {
      $("#search-date-received-input").addClass("hidden");
    };
  }

  toggleDateDueOptions = function () {
    if ($('#search_options_date_due').prop("checked")) {
      $("#search-date-due-input.hidden").removeClass("hidden");
    } else {
      $("#search-date-due-input").addClass("hidden");
    };
  }

  toggleTypeOfPaymentOptions = function() {
    if ($('#search_options_search_by_type_of_payment').prop("checked")) {
      $("#search-type-of-payment-input.hidden").removeClass("hidden");
    } else {
      $("#search-type-of-payment-input").addClass("hidden");
      // remove checked from both payment options
      $("#search_options_type_of_payment_card").prop( "checked", false );
      $("#search_options_type_of_payment_cash").prop( "checked", false );
    };
  }

  togglePaidForOptions = function() {
    if ($('#search_options_search_by_paid_for').prop("checked")) {
      $("#search-paid-for-input.hidden").removeClass("hidden");
    } else {
      $("#search-paid-for-input").addClass("hidden");
      // remove checked from both payment options
      $("#search_options_paid_for_1").prop( "checked", false );
      $("#search_options_paid_for_0").prop( "checked", false );
    };
  }

  $("#shoe_custom_product_type").on("click", function() {
    if ($('#shoe_custom_product_type').prop("checked")) {
      $(".product-type-input-field").prop( "disabled", false )
      $("#shoe_product_type").prop( "disabled", true )
    } else {
      $(".product-type-input-field").prop( "disabled", true )
      $("#shoe_product_type").prop( "disabled", false )
    }
  })
});
