# frozen_string_literal: true
class Admin::BaseController < ActionController::Base
  before_action :authenticate_admin_user!
  before_action :set_locale
  before_action :set_view_path

  layout 'admin'

  unless Rails.env.development?
    rescue_from ActiveRecord::RecordNotFound,
                ActionController::RoutingError,
                ActionController::UnknownFormat,
                ActionController::MethodNotAllowed,
                with: :handle_404
  end

  rescue_from CanCan::AccessDenied, with: :handle_unauthorized

  def handle_unauthorized
    if current_admin_user.nil? || current_admin_user.disabled?
      render file: 'public/404.html', status: 403
    else
      redirect_to admin_root_path, alert: 'Permission denied'
    end
  end

  def current_ability
    @current_ability ||= Admin::Ability.new(current_admin_user)
  end

  protected

  def body_class
    "admin #{controller_name} #{action_name}"
  end
  helper_method :body_class

  def user_for_rollbar
    current_admin_user
  end

  private

  def set_locale
    I18n.locale = 'en'
  end

  def set_view_path
    prepend_view_path 'app/views/admin'
    prepend_view_path "app/views/#{controller_path}"
  end
end
