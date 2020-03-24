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

    @show_back = request.referer&.starts_with?(sellers_url)
    load_other_sellers
  end

  private

  def load_categories
    @categories = Category.all
  end

  def load_other_sellers
    base_scope = Seller.where.not(id: @seller.id).order('RANDOM()').limit(4)
    @other_sellers = base_scope.where(city: @city)
    @other_sellers_local = true

    if @other_sellers.none?
      @other_sellers = base_scope.where(category: @seller.category)
      @other_sellers_local = false
    end

  end

end
