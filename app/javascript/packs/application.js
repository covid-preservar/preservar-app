// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import $ from "jquery";
window.$ = $;

import "popper.js";
import "../vendor/bootstrap";
import Rails from "@rails/ujs";
import Turbolinks from "turbolinks";

window.Rails = Rails;
Rails.start();
Turbolinks.start();

import '@client-side-validations/client-side-validations'
import '@client-side-validations/simple-form/dist/simple-form.bootstrap4'
import '../src/location_autocomplete';
import '../src/new_voucher_form';
import '../src/smooth_scroll';
import '../src/analytics';

import PlaceForm from "../src/place_form";
window.PlaceForm = PlaceForm;

import VoucherPaymentForm from "../src/voucher_payment_form";
window.VoucherPaymentForm = VoucherPaymentForm;

import MobileShare from "../src/mobile_share";


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
function setup() {
  if ($("body").is(".registrations.new, .places.new") && !window.place_form) {
    window.place_form = new PlaceForm();
  }

  if ($('body').is('.payments') && !window.voucher_payment_form) {
    window.voucher_payment_form = new VoucherPaymentForm();
  }

  $('[data-toggle="tooltip"]').tooltip();

  $(".alert-dismissible").on("closed.bs.alert", _ => {
    if ($('.alert').length == 0) {
      $(".flashes").hide();
    }
  });

  if ("share" in navigator && $(".js-mobileShare").length > 0) {
    new MobileShare();
  }

}


document.addEventListener('DOMContentLoaded', setup, { once: true });
document.addEventListener('turbolinks:load', setup, { once: true });
document.addEventListener("turbolinks:render", setup);