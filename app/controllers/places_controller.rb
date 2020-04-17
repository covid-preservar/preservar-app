# frozen_string_literal: true
class PlacesController < ApplicationController
  before_action :load_place_and_ensure_canonical_url, only: [:show]

  def index
    @city = params[:city]

    search = PlaceSearch.new(category: params[:category], city: @city)

    @category = search.category
    @places = search.places
    @title = search.title
  end

  def show
    @city = @place.area
    @category = @place.category
    @voucher = @place.vouchers.new
    @other_places = OtherPlacesQuery.for_place(@place)

    @show_back = request.referer.present? && URI.parse(request.referer).path == places_path
  end

  # temporary page for seller registration success
  # until we have a seller login area
  def register_success
  end

  private

  def load_place_and_ensure_canonical_url
    @place = Place.published.includes([:category]).friendly.find(params[:id])

    redirect_to(place_url(@place)) and return if place_url(@place) != request.url
  end
end
