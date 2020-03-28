# frozen_string_literal: true
class SellersController < ApplicationController

  def index
    @city = params[:city] || 'Grande Lisboa'
    @category = Category.find(params[:category] || 1)
    @sellers = @category.sellers.where(area: @city)
  end

  def show
    @seller = Seller.friendly.find(params[:id])
    @city = @seller.area
    @category = @seller.category
    @voucher = @seller.vouchers.new

    @show_back = request.referer.present? && URI.parse(request.referer).path == sellers_path
    @other_sellers = OtherSellersQuery.for_seller(@seller)
  end

  # temporary page for seller registration success
  # until we have a seller login area
  def register_success

  end

  private

  def load_categories
    @categories = Category.all
  end
end
