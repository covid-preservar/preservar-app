# frozen_string_literal: true
class BaseUploader < Shrine
  plugin :validation_helpers
  plugin :remove_invalid

  def generate_location(io, derivative: nil, **context)
    type = context[:record]&.class&.name&.downcase
    id = context[:record]&.id
    attachment = context[:name]
    style = derivative == :original ? 'originals' : derivative if derivative.present?

    name = super # the default unique identifier
    hash = Digest::SHA1.hexdigest [type, id, attachment].compact.join('/')

    [attachment, hash, style, name].compact.join('/')
  end

  class Attacher
    def optimize_image(image)
      image_optim = ImageOptim.new
      image_optim.optimize_image!(image.path)

      image
    end
  end
end
