export default class PlaceForm {
  constructor() {
    $('#district_select').change( ev => {
      let areas = gon.locations[ev.target.value]
      if (areas) {
        $('#area_select').empty()
        areas.forEach(area => {
          $('#area_select').append($("<option></option>").attr("value", area).text(area))
        })
      }
    })

    window.ClientSideValidations.callbacks.form.fail = function(form, eventData) {
      let error_wrapper = form[0].ClientSideValidations.settings.html_settings.wrapper_error_class;

      $(`.${error_wrapper}`)[0].scrollIntoView({
        behavior: 'smooth'
      })
    }

    if ($(".form-group-invalid").length > 0) {
      $(".form-group-invalid")[0].scrollIntoView({
        behavior: "smooth",
      });
    }
  }
}


function setup() {
  if ($("#new_seller_user, #new_place").length > 0 && !window.place_form) {
    window.place_form = new PlaceForm();
  }
}

document.addEventListener("DOMContentLoaded", setup, { once: true });
document.addEventListener("turbolinks:load", setup, { once: true });
document.addEventListener("turbolinks:render", setup);

document.addEventListener("turbolinks:before-render", (_) => {
  window.place_form = null;
});
