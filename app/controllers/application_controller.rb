class ApplicationController < ActionController::Base
  before_action :set_locale

  protected

  def body_class
    "#{controller_name}-#{action_name}"
  end
  helper_method :body_class

  def set_locale
    I18n.locale = 'pt'
  end
end
