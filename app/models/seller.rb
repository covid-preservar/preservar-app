class Seller < ApplicationRecord

  extend FriendlyId
  friendly_id :slug_candidates, use: [:slugged, :history]

  include PhotoUploader::Attachment.new(:main_photo)

  belongs_to :category
  has_many :vouchers

  private

  def slug_candidates
    [
      :name,
      [:name, :city],
      [:name, :city, id],
    ]
  end
end
