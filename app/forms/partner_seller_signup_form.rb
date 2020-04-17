# frozen_string_literal: true
class PartnerSellerSignupForm < SellerSignupForm
  attr_accessor :partner_id_code,
                :partner

  validates :partner_id_code, presence: true, if: -> { partner.requires_partner_id_code }
  validate :partner_id_valid

  def initialize(attributes = {})
    super(attributes)
  end

  def partnership
    @partnership ||= partner.partnerships.build(place: place, partner_identifier: partner_identifier)
  end

  def partner_identifier
    @partner_identifier ||= partner.partner_identifiers.find_by(identifier: partner_id_code)
  end

  def save
    place.category = partner.restricted_categories.first if partner.restricted_categories&.length == 1
    partnership.approved = partner_identifier.present?
    super do
      partnership.save!
      partner_identifier.mark_used! if partner.requires_partner_id_code
    end
  end

  private

  def partner_id_valid
    errors.add(:partner_id_code, "inválido") if partner.requires_partner_id_code && partner_identifier.blank?
  end
end
