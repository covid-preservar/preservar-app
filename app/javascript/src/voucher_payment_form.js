export default class SellerForm {
  constructor() {
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