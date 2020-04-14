# frozen_string_literal: true
class PartnerSellerSignupForm < SellerSignupForm
  attr_accessor :partner_id_code,
                :partner

  validates :partner_id_code, presence: true
  validate :partner_id_valid

  def initialize(attributes = {})
    super(attributes)
    if partner.restricted_category.present?
      @category_id = partner.restricted_category_id
    end
  end

  def partnership
    @partnership ||= partner.partnerships.build(place: place)
  end

  def partner_identifier
    @partner_identifier ||= partner.partner_identifiers.unused.find_by(identifier: partner_id_code)
  end

  def save
    place.category = partner.restricted_category if partner.restricted_category.present?
    super do
      partnership.save!
      partner_identifier.mark_used!(place: place)
    end
  end

  private

  def partner_id_valid
    errors.add(:partner_id_code, "inválido") unless partner_identifier.present?
  end
end
