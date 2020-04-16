# frozen_string_literal: true
class CharityPartner < Partner

  def charity_partner?
    true
  end

  def charity_value
    partner_properties['charity_value'].to_i
  end

  def charity_value=(value)
    partner_properties['charity_value'] = value
  end

  def target_progress
    vouchers.paid.count * charity_value
  end
end
