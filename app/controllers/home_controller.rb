# frozen_string_literal: true
class HomeController < ApplicationController
  before_action :set_location

  def index
    if Flipper.enabled?(:selling)
      @spinner_categories = %w[Restaurante Café Cabeleireiro Museu Teatro]
      @places = Place.published.includes(:category).order("RANDOM()").limit(4)
    end

    @stats_cache = [Place.published.maximum(:updated_at), Voucher.for_stats.maximum(:payment_completed_at)]
  end

  def tos
  end

  def tos_mbway
  end

  def privacy
  end

  def privacy
  end
end
