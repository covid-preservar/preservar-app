class Category < ApplicationRecord
  has_many :sellers

  validates :name, :name_plural, presence: true

end