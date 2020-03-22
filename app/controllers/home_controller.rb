class HomeController < ApplicationController

  def index
    @categories = Category.with_sellers
    render :index, layout:'homepage'
  end

  def tos
  end

  def privacy
  end
end