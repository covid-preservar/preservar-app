# frozen_string_literal: true
class Seller::AccountsController < Seller::BaseController

  def show
    @seller = current_seller_user.seller
  end

  def accept_new_terms
    current_seller_user.accept_tos!
    redirect_to request.referrer
  end
end
