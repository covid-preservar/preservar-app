# frozen_string_literal: true
class SellersController < ApplicationController

  def index
    @city = params[:city]
    @category = Category.find(params[:category])
    @sellers = @category.sellers.where(city: params[:city])
  end

  def show
    @seller = Seller.friendly.find(params[:id])
    @city = @seller.city
    @category = @seller.category

    @other_sellers = Seller.where(city: @city).where.not(id: @seller.id).order('RANDOM()').limit(4)

    @show_back = request.referer&.starts_with?(sellers_url)
  end

  private

  def load_categories
    @categories = Category.all
  end
end
