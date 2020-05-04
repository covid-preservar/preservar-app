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
    if partner.partner_properties['partner_types'].present?
      @partner_types = partner.partner_properties['partner_types'].invert.sort
    end
  end

  def partnership
    @partnership ||= partner.partnerships.build(place: place, partner_identifier: partner_identifier)
  end

  def partner_identifier
    @partner_identifier ||= partner.partner_identifiers.find_by(identifier: partner_id_code)
  end

  def save
    if partner.restricted_categories&.length == 1
      self.category_id = place.category = partner.restricted_categories.first
    end

    set_partnership_properties

    super do
      partnership.save!
      partner_identifier&.mark_used!
    end
  end

  private

  def partner_id_valid
    case partner_type
    when 'direct'
      validate_direct_partner_id
    when 'distributor'
      validate_distributor_partner_id
    when 'not_client'
      errors.add(:partner_type, "inválido")
    else
      validate_partner_id
    end
  end

  def validate_direct_partner_id
    errors.add(:partner_id_code, "inválido") if partner_identifier.blank?
  end

  def validate_distributor_partner_id
    errors.add(:partner_alt_id, "inválido") if partner_alt_id.blank?
  end

  def validate_partner_id
    if partner.requires_partner_id_code && partner_identifier.blank?
      errors.add(:partner_id_code, "inválido")
    elsif partner_identifier&.vat_id&.present? &&
          vat_id.sub('PT', '') != partner_identifier.vat_id
      errors.add(:partner_id_code, "não corresponde ao NIF")
    end
  end

  def set_partnership_properties
    partnership.approved = partner_identifier.present? || partner_alt_id.present?
    partnership.properties['honor_check'] = honor_check if partner.requires_honor_check
    partnership.properties['partner_type'] = partner_type if partner_type.present?
    partnership.properties['distributor_id'] = partner_alt_id if partner_alt_id.present?
  end
end
