class HomeController < ApplicationController

  def index
    @categories = Category.with_sellers
  end

  def tos
  end

  def privacy
  end
end