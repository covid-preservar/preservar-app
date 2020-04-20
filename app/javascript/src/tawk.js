function setup() {
  window.$_Tawk = undefined;
  var Tawk_API=Tawk_API||{}, Tawk_LoadStart=new Date();
  let tawk_id = $('meta#tawk-id').data('value')

  if (tawk_id) {
    (function () {
      var s1 = document.createElement("script"),
        s0 = document.getElementsByTagName("script")[0];
      s1.async = true;
      s1.src = `https://embed.tawk.to/${tawk_id}/default`;
      s1.charset = "UTF-8";
      s1.setAttribute("crossorigin", "*");
      s0.parentNode.insertBefore(s1, s0);
    })();
  }
}

document.addEventListener("turbolinks:load", setup, { once: true });
