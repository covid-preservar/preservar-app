# frozen_string_literal: true
class PartnersController < ApplicationController
  skip_before_action :load_cities

  def index
    @partner = Partner.find_by(slug: request.subdomain)

    if params[:city].present?
      search = PlaceSearch.new(category: @partner.restricted_category_id, city: params[:city])
      @places = search.places
    else
      @places = @partner.places.published
    end

    @cities = @places.pluck(:area).uniq.sort

    render @partner.slug
  end

  protected

  def body_class
    "#{super} #{@partner.slug}"
  end
end
