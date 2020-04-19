class MailjetService
  BASE_URL = "https://#{ENV["MAILJET_API_KEY"]}:#{ENV["MAILJET_SECRET_KEY"]}@api.mailjet.com/v3/REST"

  # Add a contact to a mailjet contact list.
  # Mailjet's gem is horribly broken and useless,
  # so we have to go low-level and use rest-client directly
  def self.add_seller(seller)

    # Add the email to Mailjet
    contact_id = RestClient.post(BASE_URL + "/contact",
                    {email: seller.seller_user.email}.to_json,
                    content_type: :json) do |response, request, result|

      case response.code
      when 400
        get_mailjet_id(seller.seller_user.email)
      when 200, 201
        response = JSON.parse response.body
        response.fetch('Data')&.first&.fetch('ID')
      else
        Rails.logger.warn("Failed to add email '#{seller.seller_user.email}' to Mailjet. Response was #{response.code}")
        nil
      end
    end

    Rails.logger.warn("Failed to add email or get contact_id '#{seller.seller_user.email}'") if contact_id.nil?
    return nil if contact_id.nil?

    # Set contact metadata
    params = [{ name: :nome_pessoa, value: seller.contact_name},
              { name: :nome_estabelecimento, value: seller.places.first.name},
              { name: :tipo, value: seller.places.first.category.name},
              { name: :link_detalhe, value: Rails.application.routes.url_helpers.place_url(seller.places.first)}]

    RestClient.put(BASE_URL + "/contactdata/#{contact_id}",
                   {'Data': params}.to_json,
                   content_type: :json)

    params = { ContactID: contact_id, ListID: ENV["MAILJET_CONTACT_LIST_ID"]}
    RestClient.post(BASE_URL + "/listrecipient",
                            params.to_json,
                            content_type: :json) do |response, request, result|
      case response.code
      when 400
        Rails.logger.warn("'#{seller.seller_user.email}' already added to Mailjet list.")
      else
        nil
      end
    end
  end

  def self.get_mailjet_id(email)
    RestClient.get(BASE_URL + "/contact/#{email}") do |response, request, result|
      case response.code
      when 200
        response = JSON.parse response.body
        return response.fetch('Data')&.first&.fetch('ID')
      else
        Rails.logger.warn("Failed to get email '#{email}' from Mailjet. Response was #{response.code}")
        return nil
      end
    end
  end
end