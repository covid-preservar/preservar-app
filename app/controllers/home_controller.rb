# frozen_string_literal: true
class HomeController < ApplicationController
  before_action :set_location

  def index
    @spinner_categories = %w[Restaurante Café Cabeleireiro Museu Teatro]
    @places = Place.published.includes(:category).order("RANDOM()").limit(4)

    @stats_cache = [Place.published.maximum(:updated_at), Voucher.paid.maximum(:payment_completed_at)]
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
    city = Location.find_location(location.city)&.area if location&.city.present?
    state = Location.find_location(location.state)&.area if location&.state.present?

    if city.present? && city.in?(@cities)
      @city = city
    elsif state.present? && state.in?(@cities)
      @city = state
    else
      @city = nil
    end
  end
end
