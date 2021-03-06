import NewVoucherForm from "./new_voucher_form";

function setup() {
  spinner.stop();

  if ($("#new_voucher").length > 0 && !window.voucher_form) {
    window.voucher_form = new NewVoucherForm();
  }

  $('[data-toggle="tooltip"]').tooltip();

  $('.alert-dismissible').on('closed.bs.alert', (_) => {
    if ($('.alert').length == 0) {
      $('.flashes').hide();
    }
  });

  if ('share' in navigator && $('.js-mobileShare').length > 0) {
    new MobileShare();
  } else {
    $('.js-mobileShare').hide();
  }
}

document.addEventListener('DOMContentLoaded', setup, { once: true });
document.addEventListener('turbolinks:load', setup, { once: true });
document.addEventListener('turbolinks:render', setup);

document.addEventListener('turbolinks:load', function (event) {
  for (let form of document.querySelectorAll(
    'form[method=get][data-remote=true]'
  )) {
    form.addEventListener('ajax:beforeSend', function (event) {
      const detail = event.detail,
        xhr = detail[0],
        options = detail[1];

      Turbolinks.visit(options.url);
      event.preventDefault();
    });
  }

  $('.select-input.city').select2({
    theme: 'bootstrap4',
    width: 'style',
    data: gon.locations,
    placeholder: 'Pesquisar local',
  });
});