# frozen_string_literal: true
class Partnership < ApplicationRecord
  belongs_to :partner, inverse_of: :partnerships
  belongs_to :place, inverse_of: :partnership, touch: true
  belongs_to :partner_identifier, optional: true

  def honor_check
    properties['honor_check']
  end

  def honor_check=(value)
    properties['honor_check'] = value
  end

  def partner_type
    properties['partner_type']
  end

  def partner_type=(value)
    properties['partner_type'] = value
  end

  def distributor_id
    properties['distributor_id']
  end

  def distributor_id=(value)
    properties['distributor_id'] = value
  end

  def partner_id_code
    partner_identifier&.identifier
  end

  def partner_id_code=(value)
    self.partner_identifier = partner.partner_identifiers.find_by(identifier: partner_id_code)
  end

  def to_s
    "Partnership #{id} — #{partner.name}"
  end
end
