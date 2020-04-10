class CharityPartner < Partner

  def is_charity_partner?
    true
  end

  def min_value
    partner_properties['min_value']
  end

  def min_value=(value)
    partner_properties['min_value'] = value
  end

  def charity_value
    partner_properties['charity_value']
  end

  def charity_value=(value)
    partner_properties['charity_value'] = value
  end
end