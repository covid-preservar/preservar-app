export default class SellerForm {
  constructor() {
    if ($('.seller_user_is_company input:checked').val() == 'false') {
      $('#company-data').hide()
    }

    $('.seller_user_is_company input').change(ev => {
      if (ev.target.value == 'true') {
        $('#company-data').fadeIn()
      } else {
        $('#company-data').fadeOut()
      }
    })
  }
}
