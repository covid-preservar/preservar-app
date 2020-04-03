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
  }
}
