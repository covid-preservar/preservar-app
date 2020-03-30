class SellerPostSignupJob < ApplicationJob
  queue_as :default

  def perform(seller_id)
    seller = Seller.unscoped.find(seller_id)

    # We must do this first.
    # If we send the mail first, the contact gets auto-added
    # The API errors if we try to add again, and
    # we don't have an ID to add to the list or add the metadata.
    # Crappy API design and a useless gem on top of it.
    if ENV["MAILJET_CONTACT_LIST_ID"].present?
      add_to_mailjet(seller)
    end

    ApplicationMailer.seller_signup(seller).deliver_now
    ApplicationMailer.seller_signup_notify_internal(seller).deliver_now
  end

  private

  # Add a contact to a mailjet contact list.
  # Mailjet's gem is horribly broken and useless,
  # so we have to go low-level and use rest-client directly
  def add_to_mailjet(seller)
    base_url = "https://#{ENV["MAILJET_API_KEY"]}:#{ENV["MAILJET_SECRET_KEY"]}@api.mailjet.com/v3/REST"

    # Add the email to Mailjet
    response = RestClient.post(base_url + "/contact",
                               {email: seller.seller_user.email}.to_json,
                               content_type: :json)
    response = JSON.parse response.body
    contact_id = response.fetch('Data')&.first&.fetch('ID')

    # Set contact metadata
    params = [{ name: :nome_pessoa, value: seller.contact_name},
              { name: :nome_estabelecimento, value: seller.name},
              { name: :tipo, value: seller.category.name}]

    RestClient.put(base_url + "/contactdata/#{contact_id}",
                   {'Data': params}.to_json,
                   content_type: :json)

    params = { ContactID: contact_id, ListID: ENV["MAILJET_CONTACT_LIST_ID"]}
    RestClient.post(base_url + "/listrecipient",
                    params.to_json,
                    content_type: :json)
  end
end