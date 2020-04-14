# frozen_string_literal: true
class Place < ApplicationRecord
  DEFAULT_EUR_VALUES = [20, 30, 40, 50].map { |v| ["€#{v}", v] }

  extend FriendlyId
  friendly_id :slug_candidates, use: %i[history]

  include PhotoUploader::Attachment.new(:main_photo)
  belongs_to :category
  belongs_to :seller
  has_many :vouchers, dependent: :restrict_with_exception

  has_one :partnership, inverse_of: :place
  has_one :partner, through: :partnership, inverse_of: :places
  has_one :partner_identifier

  validates :name, :area, :address, :main_photo, presence: true
  validates :description, length: {maximum: 1000}
  validate  :seller_has_api_key
  validate  :valid_url

  scope :sorted, -> { order(name: :asc) }
  scope :published, -> { where(published: true) }

  default_scope -> { includes(:partnership, :partner, :category) }

  attr_accessor :district

  def can_publish?
    !published && seller&.payment_api_key&.present? && main_photo.present?
  end

  def photo_url(size)
    # fallback to original to handle the gap between upload
    # and derivative generation
    main_photo_url(size , public: true) || main_photo_url(public: true)
  end

  attr_reader :partner_id

  def partner_id=(value)
    self.partner = Partner.find_by_id(value)
  end

  def approved_partner
    partner if partnership&.approved?
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

  def should_generate_new_friendly_id?
    slug.blank? || name_changed?
  end

  def valid_url
    return true if url.blank?
    begin
      uri = URI(url)
      errors.add(:url, "not a valid http or https URL") unless uri.present? && uri.is_a?(URI::HTTP)
    rescue URI::BadURIError, URI::InvalidComponentError, URI::InvalidURIError, ArgumentError
      errors.add(:url, "not a valid http or https URL")
    end
  end
end
