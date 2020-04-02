# frozen_string_literal: true
class PlacesController < ApplicationController

  def index
    @city = params[:city] || 'Grande Lisboa'
    @category = Category.find(params[:category] || 1)
    @places = @category.places.published.where(area: @city).sorted
  end

  def show
    @place = Place.published.includes([:category]).friendly.find(params[:id])

    redirect_to(@place) and return if place_url(@place) != request.url

    @city = @place.area
    @category = @place.category
    @voucher = @place.vouchers.new

    @show_back = request.referer.present? && URI.parse(request.referer).path == places_path
    @other_places = OtherPlacesQuery.for_place(@place)
  end

  # temporary page for seller registration success
  # until we have a seller login area
  def register_success

  end

  private

  def load_categories
    @categories = Category.all
  end
end
