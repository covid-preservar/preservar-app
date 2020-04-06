export default class MobileShare {
  constructor() {
    $(".js-mobileShare").on('click', _ => {
      if (navigator.share) {
        navigator.share({
          title: document.title,
          url: document.location.href,
          text: document.title
        });
      }
    });
  }
}
