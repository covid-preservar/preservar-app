
function setup() {
  analytics_id = $('meta#google-analytics-id').data('value')

  if (!analytics_id) {return; }

  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());
  gtag('config', analytics_id, { 'anonymize_ip': true });
}

document.addEventListener('turbolinks:load', setup, { once: true });
