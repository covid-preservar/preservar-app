# frozen_string_literal: true
class HomeController < ApplicationController
  before_action :set_location

  def index
    @spinner_categories = %w[Restaurante Café Cabeleireiro Museu Teatro]
    @places = Place.published.order("RANDOM()").limit(20)
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
