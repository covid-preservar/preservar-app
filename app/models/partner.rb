# frozen_string_literal: true
class Partner < ApplicationRecord

  include PartnerLogoUploader::Attachment.new(:large_logo)
  include SmallPartnerLogoUploader::Attachment.new(:small_logo)

  has_many :partnerships, inverse_of: :partner, dependent: :destroy
  has_many :places, through: :partnerships, inverse_of: :partner
  has_many :vouchers
  has_many :partner_identifiers

  def logo_url
    large_logo_url(:large, public: true) || large_logo_url(public: true)
  end

  def thumb_logo_url
    small_logo_url(public: true)
  end

  def discount_partner?
    false
  end

  def charity_partner?
    false
  end

  def restricted_category_id
    partner_properties['restricted_category_id']
  end

  def restricted_category_id=(value)
    partner_properties['restricted_category_id'] = value
  end

  def restricted_category
    if partner_properties['restricted_category_id'].present?
      Category.find_by(id: partner_properties['restricted_category_id'])
    end
  end

  def restricted_category=(category)
    partner_properties['restricted_category_id'] = category.id
  end

  def requires_partner_id_code
    partner_properties['requires_partner_id_code'] || false
  end

  def requires_partner_id_code=(value)
    partner_properties['requires_partner_id_code'] = value == '1'
  end
end
