# frozen_string_literal: true
class ShrineField < Administrate::Field::Base
  def url
    data.try(:url).to_s
  end

  def url_only?
    options.fetch(:url_only, false)
  end

  def cached_value
    resource.send("cached_#{attribute}_data")
  end
end
