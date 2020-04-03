# frozen_string_literal: true
class HomeController < ApplicationController
  before_action :set_location

  def index
    @spinner_categories = Category.order('RANDOM()').limit(5)
    @category = Category.find(1)
    @places = @category.places.order("RANDOM()").limit(20)
    render :index
  end

  def tos
  end

  def privacy
  end

  def privacy
  end

  private

  def set_location
    location = request.location
    detected_city = location&.city.presence || location&.state.presence
    @city = Location.find_location(detected_city) || 'Grande Lisboa'
  end
end
