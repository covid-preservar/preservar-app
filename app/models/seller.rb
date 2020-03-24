class Seller < ApplicationRecord
  include PhotoUploader::Attachment.new(:main_photo)

  belongs_to :category
  has_many :vouchers
end
