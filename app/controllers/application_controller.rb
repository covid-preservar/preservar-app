class ApplicationController < ActionController::Base
  before_action :set_locale
  before_action :load_categories

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
    # @categories = Category.with_sellers
    @categories = Category.all
  end
end
