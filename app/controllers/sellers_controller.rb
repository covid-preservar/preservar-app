class SellersController < ApplicationController

  def index
    @city = params[:city]
    @category = Category.find(params[:category])
    @sellers = @category.sellers.where(city: params[:city])
  end

  private

  def load_categories
    @categories = Category.all
  end
end