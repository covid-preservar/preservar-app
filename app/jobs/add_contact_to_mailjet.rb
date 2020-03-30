class AddContactToMailjet < ApplicationJob
  queue_as :default

  # Add a contact to a mailjet contact list.
  # Mailjet's gem is horribly broken and useless,
  # so we have to go low-level and use rest-client directly
  def perform(seller_id)
    seller = Seller.unscoped.find(seller_id)
    base_url = "https://#{ENV["MAILJET_API_KEY"]}:#{ENV["MAILJET_SECRET_KEY"]}@api.mailjet.com/v3/REST"

    # Add the email to Mailjet
    response = RestClient.post(base_url + "/contact",
                               {email: seller.email}.to_json,
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