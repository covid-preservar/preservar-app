export default class Spinner {
  constructor() {
    document.addEventListener("turbolinks:request-start", this.start);
    document.addEventListener("ajax:send", this.start);
    document.addEventListener("turbolinks:request-end", this.stop);
    document.addEventListener("ajax:complete", this.stop);
  }

  start() {
    this.timer = setTimeout( _ => {
      $(".spinner-wrapper").removeClass("spinner--stopped");
    }, 500);
  }

  stop() {
    clearTimeout(this.timer);
    $(".spinner-wrapper").addClass("spinner--stopped");
  }
}

