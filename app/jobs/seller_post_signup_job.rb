# frozen_string_literal: true
class SellerPostSignupJob < ApplicationJob
  queue_as :default

  def perform(seller_id)
    seller = Seller.find(seller_id)

    # We must do this first.
    # If we send the mail first, the contact gets auto-added
    # The API errors if we try to add again, and
    # we don't have an ID to add to the list or add the metadata.
    # Crappy API design and a useless gem on top of it.
    if ENV["MAILJET_CONTACT_LIST_ID"].present?
      MailjetService.add_seller(seller)
    end

    ApplicationMailer.seller_signup(seller).deliver_now
  end
end
