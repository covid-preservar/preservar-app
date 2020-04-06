export default class Spinner {
  constructor() {
    document.addEventListener("turbolinks:request-start", this.start);
    document.addEventListener("ajax:send", this.start);
    document.addEventListener("turbolinks:request-end", this.stop);
    document.addEventListener("ajax:complete", this.stop);
  }

  start() {
    $(".spinner-wrapper").removeClass("spinner--stopped");
  }

  stop() {
    $(".spinner-wrapper").addClass("spinner--stopped");
  }
}

