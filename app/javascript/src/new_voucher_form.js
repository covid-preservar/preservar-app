export default class NewVoucherForm {
  constructor() {
    $("#voucher_custom_value").on("input", (ev) => {
      $("#voucher_custom_value").parent().addClass("selected");
      $(".radio_buttons").prop("checked", false);
    });

    $(".radio_buttons").change((_) => {
      $("#voucher_custom_value").val(null);
      $("#voucher_custom_value").parent().removeClass("selected");
    });

    if ($("#voucher_custom_value").val()) {
      $("#voucher_custom_value").parent().addClass("selected");
      $(".radio_buttons").prop("checked", false);
    }
  }
}

function setup() {
  if ($("#new_voucher").length > 0 && !window.voucher_form) {
    window.voucher_form = new NewVoucherForm();
  }
}

document.addEventListener("DOMContentLoaded", setup, { once: true });
document.addEventListener("turbolinks:load", setup, { once: true });
document.addEventListener("turbolinks:render", setup);

document.addEventListener("turbolinks:before-render", _ => {
  window.voucher_form = null;
});
