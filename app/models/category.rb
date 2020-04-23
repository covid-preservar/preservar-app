# frozen_string_literal: true
class Category < ApplicationRecord
  has_many :places, dependent: :restrict_with_exception

  validates :name, :name_plural, presence: true

  scope :with_places, -> { where(id: Place.published.distinct(:category_id).select(:category_id)) }

end
