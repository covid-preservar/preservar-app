# frozen_string_literal: true
class Seller < ApplicationRecord
  DEFAULT_EUR_VALUES = [20, 30, 40, 50].map { |v| ["€#{v}", v] }

  extend FriendlyId
  friendly_id :slug_candidates, use: %i[slugged history]

  include PhotoUploader::Attachment.new(:main_photo)

  belongs_to :category
  has_one :seller_user, dependent: :destroy
  has_many :vouchers, dependent: :restrict_with_exception

  scope :sorted, -> { order(name: :asc) }
  scope :published, -> { where(published: true) }

  validates :area, :address, presence: true
  validates :payment_api_key, presence: true, if: :published?
  validates :seller_user, presence: true, if: :published?

  def can_publish?
    payment_api_key.present? && main_photo.present?
  end

  private

  def slug_candidates
    [
      :name,
      %i[name area],
      %i[name area id]
    ]
  end
end
