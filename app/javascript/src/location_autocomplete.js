import "awesomplete";

function setup() {
  if ($(".input-location").length > 0 && !window.location_completers) {
    window.location_completers = []
    $(".input-location").map((_, input) => {
      window.location_completers.push(new Awesomplete(input, {list: gon.cities, minChars: 1}));
    });
  }
}

function teardown() {
  if (window.location_completers) {
    window.location_completers.forEach((completer) => completer.destroy());
    window.location_completers = null;
  }
}

document.addEventListener('DOMContentLoaded', setup, { once: true });
document.addEventListener('turbolinks:load', setup, { once: true });
document.addEventListener("turbolinks:render", setup);
document.addEventListener("turbolinks:before-render", teardown);