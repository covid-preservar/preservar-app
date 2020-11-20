class VoucherPDFWriter
  include Prawn::View

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
    logo
    header
    details
    filename = Rails.root.join("tmp/voucher_#{@voucher.code}.pdf")
    save_as(Rails.root.join(filename))

    filename
  end

  def logo
    canvas do
      rectangle [0, bounds.top], bounds.right * 0.8, bounds.top / 2
      fill_color 'EFF5FF'
      fill
      image Rails.root.join('app/assets/images/logo-mail.png'), position: 50, vposition: 50, width: 100
    end
  end

  def header
    move_down 100
    font('GangsterGrotesk', size: 40) do
      fill_color '00093C'
      bounding_box([25, cursor], width:  bounds.right - 75) do
        text "Voucher"
        text @voucher.place.name
      end
    end
  end

  def details
    move_down 50
    font('GangsterGrotesk', size: 20) do
      fill_color '00093C'
      bounding_box([25, cursor], width:  bounds.right - 75) do
        text "Número do voucher: #{@voucher.code}"
      end
    end

    move_down 20
    font('GangsterGrotesk', size: 16) do
      fill_color '00093C'
      bounding_box([25, cursor], width:  bounds.right - 75) do
        pad(10) { text("Email: #{@voucher.email}") }
        text "Validade: #{@voucher.valid_until}"
      end
    end
  end
end
