class VoucherPDFWriter
  include Prawn::View
  include ActionView::Helpers::NumberHelper

  def initialize(voucher)
    @voucher = voucher
    font_families.update('GangsterGrotesk' => {
      normal: Rails.root.join('app/assets/fonts/GangsterGrotesk-Regular.otf'),
      light: Rails.root.join('app/assets/fonts/GangsterGrotesk-Light.otf'),
      bold: Rails.root.join('app/assets/fonts/GangsterGrotesk-Bold.otf')
    })
  end

  def document
    @document ||= Prawn::Document.new(page_size: 'A4')
  end

  def create_pdf_tempfile
    decoration
    header
    details
    filename = Rails.root.join("tmp/voucher_#{@voucher.code}.pdf")
    save_as(Rails.root.join(filename))

    filename
  end

  def decoration
    canvas do
      rectangle [bounds.left + 20, bounds.top - 20], bounds.right - 40, bounds.top - 40
      stroke_color '122675'
      line_width 2
      stroke
      image Rails.root.join('app/assets/images/logo-pdf.png'), position: 50, vposition: 50, width: 120
      image Rails.root.join('app/assets/images/email-illustration.png'), at: [bounds.right-162, 162], width: 142
    end
  end

  def header
    print_text("<b>#{number_to_currency(@voucher.value, locale: :pt, strip_insignificant_zeros: true)}</b>", 54, 100)
    print_text("Para gastar na", 20, 0, "A0A8C8")
    print_text("<b>#{@voucher.place.name}</b>", 26, 0)
  end

  def details
    print_text("Esta prenda é especial. Mas porquê?\n" \
    "O comércio local está a passar uma crise sem precedentes. Este voucher, já pago por quem lhe ofereceu, contribuiu para que o comércio local sobreviva a esta crise sem precedentes.\n" \
    "Agora, desfrute deste voucher sabendo que contribuiu para algo muito maior que nós todos.\n\n" \
    "Obrigado!", 14, 50)

    print_text("Usar este voucher é simples: mostre-o no momento de pagamento.", 14, 50)

    print_text("Código: <b>#{@voucher.code}</b>", 13, 0)
    print_text("Validade: <b>#{@voucher.valid_until}</b>", 13, 0)

    print_text("Mais informações em <b>www.preserve.pt</b>", 10, 40)
  end



  private

  def print_text(text, size, margin_top, color = "122675")
    move_down margin_top
    font('GangsterGrotesk', size: size) do
      fill_color '122675'
      bounding_box([180, cursor], width:  bounds.right - 200) do
        text text, inline_format: true
      end
    end
  end
end
