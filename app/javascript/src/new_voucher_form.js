

function setup() {
  if ($('#new_voucher').length > 0) {
    $('#voucher_custom_value').change( (ev) => {
      $('.radio_buttons').prop('checked', false)
    })
  }
}

document.addEventListener('DOMContentLoaded', setup, { once: true });
document.addEventListener('turbolinks:load', setup, { once: true });
document.addEventListener("turbolinks:render", setup);