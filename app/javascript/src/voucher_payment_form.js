export default class VoucherPaymentForm {
  constructor() {
    if ($('#new_voucher').length > 0) {
      $('#voucher_custom_value').on('input', (ev) => {
        $('.radio_buttons').prop('checked', false)
      })

      $('.radio_buttons').change(_ => {
        $('#voucher_custom_value').val(null)
      })
    }
  }
}
