# frozen_string_literal: true
class PhotoUploader < BaseUploader
  plugin :store_dimensions, analyzer: :mini_magick
  plugin :derivatives, versions_compatibility: true
  plugin :upload_options, cache: { acl: 'public-read' }
  plugin :upload_options, store: { acl: 'public-read' }
  plugin :remote_url, max_size: 5 * 1024 * 1024

  Attacher.validate do
    validate_max_size 5 * 1024 * 1024, message: 'is too large (max is 5 MB)'
    # Docs recommend validating both MIME and extension
    validate_mime_type_inclusion %w[image/jpeg image/png], message: 'must be JPEG or PNG'
    validate_extension_inclusion %w[jpg jpeg png gif], message: 'must be JPEG or PNG'
  end

  Attacher.derivatives_processor do |original|
    magick = ImageProcessing::MiniMagick.source(original)
    {
      large: optimize_image(magick.resize_to_fill!(256, 256, gravity: 'Center')),
      small: optimize_image(magick.resize_to_fill!(72, 72, gravity: 'Center'))
    }
  end

end
