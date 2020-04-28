# frozen_string_literal: true
class ApplicationController < ActionController::Base
  # Simple HTTP auth to keep users from
  # accidentaly using the test app and bots from indexing it
  http_basic_authenticate_with name: ENV["HTTP_USER"],
                               password: ENV["HTTP_PASSWORD"],
                               if: -> { ENV["HTTP_AUTH"].present? }

  before_action :set_locale
  before_action :load_categories
  before_action :load_cities
  before_action :set_cookies, unless: -> { request.xhr? }

  if !Rails.env.development?
    rescue_from ActiveRecord::RecordNotFound,
                ActionController::RoutingError,
                ActionController::UnknownFormat,
                ActionController::MethodNotAllowed,
                with: :handle_404
  end

  protected

  def body_class
    "#{controller_name} #{action_name}"
  end
  helper_method :body_class

  def set_locale
    I18n.locale = 'pt'
  end

  def after_sign_in_path_for(resource)
    case resource
    when AdminUser
      admin_root_path
    when SellerUser
      seller_account_path
    end
  end

  def mbway_bonus_active?
    Voucher.total_paid.sum(:mbway_bonus) < 5000
  end
  helper_method :mbway_bonus_active?

  private

  def load_categories
    @categories = Category.with_places.order(name: :asc)
  end

  def load_cities
    @cities = Location.grouped_areas_for_areas(Place.published.distinct(:area).select(:area))
  end

  def load_locations
    gon.locations = Location.grouped_areas
  end

  def set_location
    location = request.location
    city = Location.find_location(location.city)&.area if location&.city.present?
    state = Location.find_location(location.state)&.area if location&.state.present?
    all_cities = @cities.values.flatten

    if city.present? && city.in?(all_cities)
      @city = city
    elsif state.present? && state.in?(all_cities)
      @city = state
    else
      @city = nil
    end
  end

  def handle_404(exception)
    logger.warn("#{exception.class}: #{exception.message}")
    render file: "public/404.html", layout:nil, status: 404
  end

  def set_cookies
    referrer = get_http_referrer
    if has_tracking_codes?(params) || referrer_present?(referrer)
      clean_tracking_cookies()
      load_tracking_cookies(params, referrer)
    end
  end

  def get_http_referrer
    request.referrer.try(:strip).try(:[], 0...3000)
  end

  def has_tracking_codes?(params)
    params.keys.any? { |k| k.start_with?('utm_') }
  end

  def referrer_present?(referrer)
    referrer.present? && URI(referrer.strip).host != ENV['HOSTNAME']
  end

  def clean_tracking_cookies
    cookies.delete(:referrer)
    cookies.each do |key, _|
      cookies.delete(key) if key.start_with?('utm_')
    end
  end

  def load_tracking_cookies(params, referrer)
    expires = 7.days.from_now

    cookies.signed[:referrer] = { value: referrer, expires: expires } if referrer_present?(referrer)

    params.each do |key, value|
      if key.starts_with?('utm_')
        cookies.signed[key] = { value: value, expires: expires }
      end
    end
  end
end
