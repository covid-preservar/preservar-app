# frozen_string_literal: true
class CharityPartner < Partner

  def charity_partner?
    true
  end

  def min_value
    partner_properties['min_value'].to_i
  end

  def min_value=(value)
    partner_properties['min_value'] = value
  end

  def target_value
    partner_properties['target_value'].to_i
  end

  def target_value=(value)
    partner_properties['target_value'] = value
  end

  def charity_value
    partner_properties['charity_value'].to_i
  end

  def charity_value=(value)
    partner_properties['charity_value'] = value
  end

  def charity_progress
    vouchers.paid.count * charity_value
  end
end
