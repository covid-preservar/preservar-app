# frozen_string_literal: true
class ApplicationController < ActionController::Base
  before_action :set_locale
  before_action :load_categories, unless: -> { request.xhr? }
  before_action :load_cities, unless: -> { request.xhr? }

  # before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def body_class
    "#{controller_name} #{action_name}"
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
    gon.cities = Seller.distinct(:area).pluck(:area)
  end
end
