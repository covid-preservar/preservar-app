class Category < ApplicationRecord
  has_many :sellers

  validates :name, :name_plural, presence: true

  scope :with_sellers, -> { where(id: Seller.distinct(:category_id))}
end