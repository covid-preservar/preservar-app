# frozen_string_literal: true
class Seller::VouchersController < Seller::BaseController

  def index
    @vouchers = current_seller_user.seller.vouchers.seller_visible
  end

end
