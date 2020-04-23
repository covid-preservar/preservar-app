import $ from "jquery";
window.$ = $;

import "popper.js";
import "../vendor/bootstrap";

import Rails from "@rails/ujs";
import Turbolinks from "turbolinks";

window.Rails = Rails;
Rails.start();
Turbolinks.start();

import "@client-side-validations/client-side-validations";
import "@client-side-validations/simple-form/dist/simple-form.bootstrap4";

import Spinner from "../src/spinner";
window.spinner = new Spinner();

import Pikaday from 'pikaday'
window.Pikaday = Pikaday;


import PlaceForm from "../src/place_form";
window.PlaceForm = PlaceForm;

function setup() {
  $(".date_input").each(function () {
    if (!this.picker) {
      this.picker = new Pikaday({
        field: this,
        toString(date, format = "YYYY-MM-DD") {
          const day = date.getDate();
          const month = date.getMonth() + 1;
          const year = date.getFullYear();
          return `${year}-${String(month).padStart(2, '0')}-${day}`;
        }
      });
    }
  });

  if ($(".edit_place, #new_place").length > 0 && !window.place_form) {
    window.place_form = new PlaceForm();
  }
}


document.addEventListener("DOMContentLoaded", setup, { once: true });
document.addEventListener("turbolinks:load", setup, { once: true });
document.addEventListener("turbolinks:render", setup);
