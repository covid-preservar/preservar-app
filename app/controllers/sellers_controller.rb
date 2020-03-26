# frozen_string_literal: true
class SellersController < ApplicationController

  def index
    @city = params[:city]
    @category = Category.find(params[:category])
    @sellers = @category.sellers.where(area: params[:city])
  end

  def show
    @seller = Seller.friendly.find(params[:id])
    @city = @seller.area
    @category = @seller.category
    @voucher = @seller.vouchers.new

    @show_back = request.referer.present? && URI.parse(request.referer).path == sellers_path
    load_other_sellers
  end

  # temporary page for seller registration success
  # until we have a seller login area
  def register_success

  end

  private

  def load_categories
    @categories = Category.all
  end

  def load_other_sellers
    base_scope = Seller.where.not(id: @seller.id).order('RANDOM()').limit(4)
    @other_sellers = base_scope.where(area: @city)
    @other_sellers_local = true

    if @other_sellers.none?
      @other_sellers = base_scope.where(category: @seller.category)
      @other_sellers_local = false
    end
  end
end
