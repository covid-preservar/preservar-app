# frozen_string_literal: true
class SmallPartnerLogoUploader < PartnerLogoUploader

  Attacher.derivatives_processor do |original|
    magick = ImageProcessing::MiniMagick.source(original)
    {
      small: optimize_image(magick.resize_and_pad!(200, 200, gravity: 'Center'))
    }
  end

end
