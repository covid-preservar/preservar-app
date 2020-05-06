# frozen_string_literal: true
class SellerPostSignupJob < ApplicationJob
  queue_as :default

  def perform(seller_id)
    seller = Seller.find(seller_id)

    # Legacy - seller info was added to a Mailjet List
    # We removed Mailjet, but the job is kept in case
    # we want to use sendgrid lists

    ApplicationMailer.seller_signup(seller).deliver_now
  end
end
