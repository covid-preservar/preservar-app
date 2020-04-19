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
  }
}
