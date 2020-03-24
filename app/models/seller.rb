# frozen_string_literal: true
class Seller < ApplicationRecord
  DEFAULT_EUR_VALUES = [20, 30, 40, 50].map { |v| ["€#{v}", v] }

  extend FriendlyId
  friendly_id :slug_candidates, use: %i[slugged history]

  include PhotoUploader::Attachment.new(:main_photo)


  belongs_to :category
  has_one :seller_user, dependent: :destroy
  has_many :vouchers, dependent: :restrict_with_exception

  private

  def slug_candidates
    [
      :name,
      %i[name city],
      %i[name city id]
    ]
  end
end
