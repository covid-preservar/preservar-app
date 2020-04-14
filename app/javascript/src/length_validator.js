export default class TextLengthValidator {

  constructor(selector, classes="form-text text-muted") {
    let element = $(selector)
    element.data('old-value', element.val())
    element.after(`<small class='${classes} characters'></p>`);
    element.on('input', this.validateLength).trigger('input')
  }

  validateLength(event) {
    let element = $(event.target);
    let maxLength = parseInt(element.attr('maxlength'))
    let value = element.val().replace(/\r(?!\n)|\n(?!\r)/g, '\r\n')
    let counter = element.siblings(".characters")

    if (value.length > maxLength) {
      counter.addClass('counter-over-limit')
    } else {
      counter.removeClass('counter-over-limit')
    }

    let remaining = maxLength - value.length

    counter.text(`${remaining} / ${maxLength}`);
  }

}

