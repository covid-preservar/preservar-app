class InsurancePolicyService
  ENDPOINT = ENV['INSURANCE_ENDPOINT']
  DEFAULT_INSURANCE_EXPIRATION = ENV['INSURANCE_EXPIRATION_DATE']
  INSURANCE_API_TOKEN = ENV['INSURANCE_API_TOKEN']
  INSURANCE_API_KEY = ENV['INSURANCE_API_KEY']

  attr_accessor :voucher
  def initialize(voucher)
    @voucher = voucher
  end

  def create_policy
    headers = {
       Authorization: "Bearer #{INSURANCE_API_TOKEN}",
       content_type: :json
    }

    params = {
      partner_id: INSURANCE_API_KEY,
      email: voucher.email,
      amount: voucher.value,
      retailer: voucher.place.name,
      purchase_date: voucher.payment_completed_at.to_date,
      expiry_date: DEFAULT_INSURANCE_EXPIRATION
    }

    RestClient.post ENDPOINT, params.to_json, headers do |response, request, result|
      case response.code
      when 200
        process_response JSON.parse(response.body)
      when 404
        raise InvalidTokenOrEndpoint
      else
        raise ResponseError, "Response code was #{response.code}"
      end
    end
  end

  private

  def process_response(response)
    policy_number = response.dig('result', 'policy_number')

    case response.dig('result', 'status')
    when 101
      raise ValidationError, response.dig('result', 'errors')
    when 301
      raise PartnerIDNotVerified
    when 200
      user_credential = response.dig('result', 'cred')
      if policy_number.present? && user_credential.present?
        voucher.update! insurance_policy_number: policy_number,
                        insurance_temp_password: user_credential
      else
        raise ResponseError, "Expected policy number and credential in response for voucher #{voucher.id}"
      end
    when 201
      if policy_number.present?
        voucher.update! insurance_policy_number: policy_number
      else
        raise ResponseError, "Expected policy number in response for voucher #{voucher.id}"
      end
    else
      raise ResponseError, "Unexpected status: #{response.dig('result', 'status')}"
    end
  end

  class InvalidTokenOrEndpoint < StandardError;end
  class PartnerIDNotVerified < StandardError;end
  class ValidationError < StandardError;end
  class ResponseError < StandardError;end
end
