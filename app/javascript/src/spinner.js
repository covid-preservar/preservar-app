export default class Spinner {
  constructor() {
    document.addEventListener("turbolinks:request-start", this.start.bind(this));
    document.addEventListener("ajax:send", this.start.bind(this));
    document.addEventListener("turbolinks:request-end", this.stop.bind(this));
    document.addEventListener("ajax:complete", this.stop.bind(this));
  }

  start() {
    clearTimeout(this.timer);
    this.timer = setTimeout( _ => {
      $(".spinner-wrapper").removeClass("spinner--stopped");
    }, 500);
  }

  stop() {
    clearTimeout(this.timer);
    $(".spinner-wrapper").addClass("spinner--stopped");
  }
}

