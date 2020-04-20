export default class VoucherPaymentForm {
  constructor() {
    if (!$('.payment-method-radio:checked').val()) {
      $('.voucher_payment_phone').hide();
    }

    if ($('.payment-method-radio:checked').val() == 'MBW') {
      $('.voucher_payment_phone').show();
      $('.method-mbw').addClass('selected');
      $('.method-mb').removeClass('selected');
    } else if($('.payment-method-radio:checked').val() == 'MB') {
      $('.voucher_payment_phone').hide();
      $('.method-mb').addClass('selected');
      $('.method-mbw').removeClass('selected');
    }

    $('.payment-method-radio').change( ev => {
      if (ev.target.value == 'MBW') {
        $('.voucher_payment_phone').slideDown()
        $('.method-mbw').addClass('selected');
        $('.method-mb').removeClass('selected');
      } else if (ev.target.value == 'MB') {
        $('.voucher_payment_phone').slideUp()
        $('.method-mb').addClass('selected');
        $('.method-mbw').removeClass('selected');
      }
    })
  }
}

function setup() {
  if ($("body").is(".payments") && !window.voucher_payment_form) {
    window.voucher_payment_form = new VoucherPaymentForm();
  }
}

document.addEventListener("DOMContentLoaded", setup, { once: true });
document.addEventListener("turbolinks:load", setup, { once: true });
document.addEventListener("turbolinks:render", setup);

document.addEventListener("turbolinks:before-render", (_) => {
  window.voucher_payment_form = null;
});
