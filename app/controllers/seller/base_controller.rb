# frozen_string_literal: true
class Seller::BaseController < ApplicationController
  before_action :authenticate_seller_user!

  protected

  def body_class
    "seller-area #{super}"
  end
end
