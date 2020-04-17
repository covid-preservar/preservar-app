# frozen_string_literal: true
class PartnersController < ApplicationController
  skip_before_action :load_cities

  def index
    @partner = Partner.find_by(slug: request.subdomain)
    @places = @partner.places.published
    @cities = @partner.places.published.pluck(:area).uniq.sort

    render @partner.slug
  end

  def search
    @partner = Partner.find_by(slug: request.subdomain)

    search = PlaceSearch.new(partner: @partner, city: params[:city], name: params[:name])
    @places = search.places
  end

  protected

  def body_class
    "#{super} #{@partner.slug}"
  end
end
