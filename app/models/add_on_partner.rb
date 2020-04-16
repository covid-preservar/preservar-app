# frozen_string_literal: true
class AddOnPartner < Partner

  def add_on_partner?
    true
  end

  def add_on_value
    partner_properties['add_on_value'].to_i
  end

  def add_on_value=(value)
    partner_properties['add_on_value'] = value
  end

  def target_progress
    vouchers.paid.count * add_on_value
  end

  def active?
    target_progress < target_value
  end
end
