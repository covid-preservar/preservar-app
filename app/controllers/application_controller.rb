# frozen_string_literal: true
class ApplicationController < ActionController::Base
  before_action :set_locale
  before_action :load_categories
  before_action :load_cities

  protected

  def body_class
    "#{controller_name}-#{action_name}"
  end
  helper_method :body_class

  def set_locale
    I18n.locale = 'pt'
  end

  private

  def load_categories
    @categories = Category.with_sellers
  end

  def load_cities
    gon.cities = Seller.distinct(:city).pluck(:city)
  end
end
