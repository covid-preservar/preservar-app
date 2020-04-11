# frozen_string_literal: true
class PartnerSellerSignupForm < SellerSignupForm
  attr_accessor :partner_id_code,
                :partner

  validates :partner_id_code, presence: true

  def initialize(attributes = {})
    super(attributes)
    if partner.restricted_category.present?
      @category_id = partner.restricted_category_id
    end
  end

  def partnership
    @partnership = partner.partnerships.build(place: place)
  end

  def save
    place.category = partner.restricted_category if partner.restricted_category.present?
    super do
      partnership.save!
    end
  end
end
