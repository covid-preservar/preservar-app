# frozen_string_literal: true
class Category < ApplicationRecord
  has_many :sellers, dependent: :restrict_with_exception

  validates :name, :name_plural, presence: true

  scope :with_sellers, -> { where(id: Seller.distinct(:category_id)) }
  default_scope -> { order(name: :asc) }
end
