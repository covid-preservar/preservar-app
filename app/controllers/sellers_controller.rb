# frozen_string_literal: true
class SellersController < ApplicationController

  def index
    @city = params[:city] || 'Grande Lisboa'
    @category = Category.find(params[:category] || 1)
    @sellers = @category.sellers.published.where(area: @city).sorted
  end

  def show
    @seller = Seller.published.includes([:category]).friendly.find(params[:id])

    redirect_to(@seller) and return if seller_url(@seller) != request.url

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
