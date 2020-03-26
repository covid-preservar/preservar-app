# frozen_string_literal: true
class PhotoUploader < BaseUploader
  plugin :store_dimensions, analyzer: :mini_magick
  plugin :derivatives, versions_compatibility: true
  plugin :upload_options, cache: { acl: 'public-read' }
  plugin :upload_options, store: { acl: 'public-read' }
  plugin :remote_url, max_size: 5 * 1024 * 1024

  Attacher.validate do
    validate_max_size 10 * 1024 * 1024, message: 'demasiado grande (max. 10 MB)'
    # Docs recommend validating both MIME and extension
    validate_mime_type_inclusion %w[image/jpeg], message: 'tem que ser formato JPG'
    validate_extension_inclusion %w[jpg jpeg], message: 'tem que ser formato JPG'
  end

  Attacher.derivatives_processor do |original|
    magick = ImageProcessing::MiniMagick.source(original)
    {
      large: optimize_image(magick.resize_to_fill!(992, 992, gravity: 'Center')),
      small: optimize_image(magick.resize_to_fill!(580, 580, gravity: 'Center'))
    }
  end

end
