import "awesomplete";

function setup() {
  if ($('#location').length > 0 && !window.location_completer) {
    window.location_completer = new Awesomplete($('#location')[0], { list: gon.cities })
  }
}

document.addEventListener('DOMContentLoaded', setup, { once: true });
document.addEventListener('turbolinks:load', setup, { once: true });
document.addEventListener("turbolinks:render", setup);