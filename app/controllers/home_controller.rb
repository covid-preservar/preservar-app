class HomeController < ApplicationController
  
  def index
    @spinner_categories = Category.order("RANDOM()").limit(5)
    # @categories = Category.with_sellers
    @categories = Category.all
    render :index, layout:'homepage'
  end

  def tos
  end

  def privacy
  end
end