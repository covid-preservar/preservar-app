class HomeController < ApplicationController
  before_action :set_location

  def index
    @spinner_categories = Category.limit(5)

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