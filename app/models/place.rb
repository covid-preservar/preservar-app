# frozen_string_literal: true
class Place < ApplicationRecord
  DEFAULT_EUR_VALUES = [20, 30, 40, 50].map { |v| ["€#{v}", v] }

  extend FriendlyId
  friendly_id :slug_candidates, use: %i[slugged]

  include PhotoUploader::Attachment.new(:main_photo)
  belongs_to :category
  belongs_to :seller
  has_many :vouchers, dependent: :restrict_with_exception

  validates :name, :area, :address, :main_photo, presence: true
  validate  :seller_has_api_key

  scope :sorted, -> { order(name: :asc) }
  scope :published, -> { where(published: true) }

  attr_accessor :district

  def can_publish?
    !published && seller.payment_api_key.present? && main_photo.present?
  end

  private

  def slug_candidates
    [
      :name,
      %i[name area],
      %i[name area id]
    ]
  end

  def seller_has_api_key
    errors.add(:base, 'Seller must have API key') if published? && seller.payment_api_key.blank?
  end
end
