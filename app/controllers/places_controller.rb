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

  protected

  def body_class
    @preview ? "#{super} place-preview": super
  end

  private

  def load_place_and_ensure_canonical_url
    if params[:preview] == 'true' && seller_user_signed_in?
      @place = current_seller_user.seller.places.friendly.find(params[:id])
      @preview = true
    else
      @place = Place.published.includes([:category]).friendly.find(params[:id])

      redirect_to(place_url(@place, host: ENV['HOSTNAME'])) and return if place_url(@place, host: ENV['HOSTNAME']) != request.url
    end

  end
end
