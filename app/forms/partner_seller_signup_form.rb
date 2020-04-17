# frozen_string_literal: true
class PartnerSellerSignupForm < SellerSignupForm
  attr_accessor :partner_id_code,
                :partner_alt_id,
                :partner,
                :partner_type,
                :partner_types,
                :honor_check

  validates :partner_type, presence: true, if: -> { partner_types.present? }
  validates :honor_check, acceptance: true, if: -> { partner.requires_honor_check }
  validate :partner_id_valid

  def initialize(attributes = {})
    super(attributes)
    @partner_types = partner.partner_properties['partner_types'].invert if partner.partner_properties['partner_types'].present?
  end

  def partnership
    @partnership ||= partner.partnerships.build(place: place, partner_identifier: partner_identifier)
  end

  def partner_identifier
    @partner_identifier ||= partner.partner_identifiers.find_by(identifier: partner_id_code)
  end

  def save
    place.category = partner.restricted_categories.first if partner.restricted_categories&.length == 1
    super do
      partnership.properties['honor_check'] = honor_check if partner.requires_honor_check
      partnership.properties['partner_type'] = partner_type if partner_type.present?
      partnership.save!
      partner_identifier&.mark_used!
    end
  end

  private

  def partner_id_valid
    case partner_type
    when 'direct'
      errors.add(:partner_id_code, "inválido") if partner_identifier.blank?
    when 'distributor'
      errors.add(:partner_alt_id, "inválido") if partner_alt_id.blank?
    else
      errors.add(:partner_id_code, "inválido") if partner.requires_partner_id_code && partner_identifier.blank?
    end
  end

end
