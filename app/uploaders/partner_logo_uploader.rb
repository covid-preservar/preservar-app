# frozen_string_literal: true
class PartnerLogoUploader < BaseUploader
  plugin :upload_options, cache: { acl: 'public-read' }
  plugin :upload_options, store: { acl: 'public-read' }

  Attacher.validate do
    validate_max_size 1 * 1024 * 1024, message: 'demasiado grande (max. 1 MB)'
    # Docs recommend validating both MIME and extension
    validate_mime_type_inclusion %w[image/svg+xml image/png], message: 'tem que ser formato SVG ou PNG'
    validate_extension_inclusion %w[svg png], message: 'tem que ser formato SVG ou PNG'
  end
end
