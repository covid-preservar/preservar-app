# frozen_string_literal: true
class PartnerLogoUploader < BaseUploader
  plugin :store_dimensions, analyzer: :mini_magick
  plugin :derivatives, versions_compatibility: true
  plugin :upload_options, cache: { acl: 'public-read' }
  plugin :upload_options, store: { acl: 'public-read' }
  plugin :remote_url, max_size: 1 * 1024 * 1024

  Attacher.validate do
    validate_max_size 1 * 1024 * 1024, message: 'demasiado grande (max. 1 MB)'
    # Docs recommend validating both MIME and extension
    validate_mime_type_inclusion %w[image/jpeg image/png image/svg+xml], message: 'tem que ser formato JPG/PNG/SVG'
    validate_extension_inclusion %w[jpg jpeg png svg], message: 'tem que ser formato JPG/PNG/SVG'
  end

  Attacher.derivatives_processor do |original|
    magick = ImageProcessing::MiniMagick.source(original)
    {
      large: optimize_image(magick.resize_and_pad!(400, 400, gravity: 'Center'))
    }
  end

end
