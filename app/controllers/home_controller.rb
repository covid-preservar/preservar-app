class HomeController < ApplicationController
  before_action :set_location

  def index
    @spinner_categories = Category.order("name ASC").limit(5)
    gon.cities = Seller.distinct(:city).pluck(:city)

    render :index, layout:'homepage'
  end

  def tos
  end

  def privacy
  end

  private

  def set_location
    location = request.location
    @city = location&.city.presence || location&.state.presence || 'Lisboa'
  end
end