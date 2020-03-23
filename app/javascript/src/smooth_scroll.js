function setup() {
  $('.smooth-scroll').each((_, link) => {
    $(link).click( (ev) => {
      ev.preventDefault();
      $(ev.target.hash)[0].scrollIntoView({
        behavior: 'smooth'
      })
    })
  })
}



document.addEventListener('DOMContentLoaded', setup, { once: true });
document.addEventListener('turbolinks:load', setup, { once: true });
document.addEventListener("turbolinks:render", setup);