class Partner < ApplicationRecord

  include PartnerLogoUploader::Attachment.new(:large_logo)
  include SmallPartnerLogoUploader::Attachment.new(:small_logo)

  has_many :partnerships, inverse_of: :partners, dependent: :destroy
  has_many :places, through: :partnerships, inverse_of: :partner

  def logo_url
    large_logo_url(:large , public: true) || large_logo_url(public: true)
  end

  def thumb_logo_url
    small_logo_url(public: true)
  end

  def is_discount_partner?
    false
  end

  def is_charity_partner?
    false
  end
end
