class Partner < ApplicationRecord

  include PartnerLogoUploader::Attachment.new(:large_logo)
  include SmallPartnerLogoUploader::Attachment.new(:small_logo)

  has_many :partnerships
  has_many :places, through: :partnerships



  def logo_url
    large_logo_url(:large , public: true) || large_logo_url(public: true)
  end

  def thumb_logo_url
    small_logo_url(:small , public: true) || small_logo_url(public: true)
  end
end
