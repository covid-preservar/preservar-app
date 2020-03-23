class Seller < ApplicationRecord
  include PhotoUploader::Attachment.new(:main_photo)

  belongs_to :category

end
