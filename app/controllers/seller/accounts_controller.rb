# frozen_string_literal: true
class Seller::AccountsController < Seller::BaseController

  def show
    @seller = current_seller_user.seller
  end
end
