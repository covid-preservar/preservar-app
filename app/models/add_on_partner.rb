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

  def voucher_limit
    partner_properties['voucher_limit'].to_i
  end

  def voucher_limit=(value)
    partner_properties['voucher_limit'] = value
  end

  def target_progress
    vouchers.total_paid.sum(:add_on_bonus)
  end

  def date_limit
    Date.parse(partner_properties['date_limit']) rescue nil
  end

  def date_limit=(date)
    partner_properties['date_limit'] = date
  end

  def active?
    (target_value.zero? || (target_progress < target_value)) &&
    ((date_limit.present? && Date.today <= date_limit) || date_limit.nil?)
  end
end
