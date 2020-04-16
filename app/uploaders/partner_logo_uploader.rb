# frozen_string_literal: true
class PartnerLogoUploader < BaseUploader
  plugin :store_dimensions, analyzer: :mini_magick
  plugin :upload_options, cache: { acl: 'public-read' }
  plugin :upload_options, store: { acl: 'public-read' }
  plugin :remote_url, max_size: 1 * 1024 * 1024

  Attacher.validate do
    validate_max_size 1 * 1024 * 1024, message: 'demasiado grande (max. 1 MB)'
    # Docs recommend validating both MIME and extension
    validate_mime_type_inclusion %w[image/svg+xml image/svg], message: 'tem que ser formato SVG'
    validate_extension_inclusion %w[svg], message: 'tem que ser formato SVG'
  end
end
