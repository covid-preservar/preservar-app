task :migrate_partners => :environment do
  Partner.all.each do |x|
    x.restricted_category_ids = [x.partner_properties['restricted_category_ids']]
    x.partner_properties.delete('restricted_category_ids')
    x.save
  end

  x = CharityPartner.last
  x.becomes!(AddOnPartner)
  x.save
  z = AddOnPartner.find x.id
  z.add_on_value = z.partner_properties.delete('charity_value')
  z.save
end