export default class SellerForm {
  constructor() {
    $('#seller_user_district').change( ev => {
      let areas = gon.locations[ev.target.value]
      if (areas) {
        $('#seller_user_area').empty()
        areas.forEach(area => {
          $('#seller_user_area').append($("<option></option>").attr("value", area).text(area))
        })
      }
    })
  }
}
