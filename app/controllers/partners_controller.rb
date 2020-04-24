# frozen_string_literal: true
class PartnersController < ApplicationController
  prepend_before_action :load_partner
  before_action :set_location

  def index
    render @partner.slug
  end

  def search
    @city = params[:city]
    search = PlaceSearch.new(partner: @partner, city: @city, name: params[:name])
    @places = search.places
  end

  def tos
    if lookup_context.exists?('tos', ["partners/#{@partner.slug}"])
      render "partners/#{@partner.slug}/tos"
    else
      redirect_to tos_url
    end
  end

  def faq
    if lookup_context.exists?('faq', ["partners/#{@partner.slug}"])
      render "partners/#{@partner.slug}/faq"
    else
      redirect_to tos_url
    end
  end

  protected

  def body_class
    "#{super} #{@partner.slug}"
  end

  private

  def load_partner
    @partner = Partner.find_by(slug: request.subdomain)
  end

  def load_cities
    @cities = Location.grouped_areas_for_areas(@partner.live_places.published.distinct(:area).select(:area))
  end
end
