# frozen_string_literal: true
class PlacesController < ApplicationController
  before_action :load_place_and_ensure_canonical_url, only: [:show]

  def index
    @city = params[:city] || 'Grande Lisboa'
    @category = Category.find(params[:category] || 1)
    @places = @category.places.published.where(area: @city).sorted
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

    redirect_to(@place) and return if place_url(@place) != request.url
  end
end
