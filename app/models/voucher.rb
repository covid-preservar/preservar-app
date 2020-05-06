# frozen_string_literal: true
class Voucher < ApplicationRecord
  PAYMENT_METHODS = %w[MBW MB].freeze
  MIN_MBWAY_VALUE = 20
  BONUS_MBWAY_VALUE = 2
  MBWAY_TARGET_VALUE = 5000
  INSURANCE_PLACE_LIMIT = 500
  INSURANCE_TOTAL_LIMIT = 50000

  include AASM

  aasm column: :state do
    state :created, initial: true
    state :pending_payment, :paid, :redeemed, :refunded

    event :start_payment do
      transitions from: :created, to: :pending_payment, after: :generate_identifier
    end

    event :reset_payment do
      transitions from: :pending_payment, to: :created
    end

    event :payment_success do
      transitions from: :pending_payment, to: :paid, after: :finalize_voucher
    end

    event :redeemed do
      transitions from: :paid, to: :redeemed, after: -> { self.redeemed_at = Time.now }
    end

    event :mark_refunded do
      transitions from: :paid, to: :refunded, after: -> { self.refunded_at = Time.now }
    end
  end

  belongs_to :place
  belongs_to :partner, optional: true

  validates :code, presence: true, uniqueness: { allow_nil: true }, if: :paid?
  validates :email, format: { with: Devise.email_regexp }, if: :pending_payment?
  validates :value, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 200 }
  validates :custom_value, numericality: {
                            greater_than_or_equal_to: ->(instance) { instance.partner.min_value },
                            less_than_or_equal_to: 200,
                            allow_nil: true
                           }, if: -> { partner.present? && partner.min_value.present? }

  validates :payment_method, presence: true,
                             inclusion: { in: PAYMENT_METHODS },
                             if: :pending_payment?

  validates :payment_identifier, presence: true, if: :pending_payment?
  validates :payment_phone, format: { with: /\A\d{9}\z/ }, if: :requires_phone?

  validate :valid_vat_id

  scope :seller_visible, -> { where(state: %w[paid redeemed refunded]) }
  scope :with_bonus, -> { where.not(partner_id: nil) }
  scope :not_paid, -> {  where.not(state: %w[paid redeemed]) }
  scope :total_paid, -> {  where(state: %w[paid redeemed]) }
  scope :with_insurance, -> {  where.not(insurance_policy_number: nil) }

  before_validation :set_addon_bonus

  attr_reader :custom_value

  def custom_value=(val)
    @custom_value = val.presence
    self.value = val if val.present?
  end

  def vat_id=(value)
    write_attribute(:vat_id, "PT#{value.tr('PT', '')}")
  end

  def vat_id
    read_attribute(:vat_id)&.tr('PT', '')
  end

  def human_state_name
    case state
    when 'paid'
      'Emitido'
    when 'redeemed'
      'Utilizado'
    when 'refunded'
      'Cancelado'
    end
  end

  def update_tracking(codes)
    self.update_columns tracking_codes: codes
  end

  def has_charity_partner?
    partner.present? && partner.charity_partner?
  end

  def has_add_on_partner?
    partner.present? && partner.add_on_partner?
  end

  def face_value
    value + add_on_bonus + mbway_bonus
  end

  def mbway_bonus_available?
    Date.today <= Date.new(2020,5,11) &&
    value >= MIN_MBWAY_VALUE &&
    Voucher.total_paid.sum(:mbway_bonus) < MBWAY_TARGET_VALUE
  end

  def has_mbway_bonus?
    mbway_bonus_available? && payment_method == 'MBW'
  end

  def can_insure?
    self.paid? &&
    self.insurance_policy_number.blank? &&
    Voucher.insurance_available? &&
    place.vouchers.with_insurance.sum(:value) < INSURANCE_PLACE_LIMIT
  end

  def self.insurance_available?
    self.with_insurance.sum(:value) < INSURANCE_TOTAL_LIMIT
  end

  def redeem_with_value!(uvalue)
    if uvalue < self.face_value
      new_voucher = self.dup
      new_voucher.value = self.face_value - uvalue
      new_voucher.used_value = 0
      new_voucher.mbway_bonus = 0
      new_voucher.add_on_bonus = 0
      new_voucher.partner = nil
      new_voucher.generate_code
    end

    self.used_value = uvalue
    self.class.transaction do
      self.redeemed!
      new_voucher.save! if new_voucher.present?
    end

    return new_voucher.presence
  end

  protected

  def generate_code
    # Ensure uniqueness
    loop do
      self.code = SecureRandom.hex(3).upcase
      break unless self.class.where(code: self.code).exists?
    end
  end

  private

  def finalize_voucher
    self.valid_until = Date.today + 24.months
    self.payment_completed_at = Time.now
    self.mbway_bonus = BONUS_MBWAY_VALUE if has_mbway_bonus?

    generate_code
  end

  def generate_identifier
    self.payment_identifier = "p#{place_id}s#{place.seller_id}v#{id}_#{payment_method.downcase}_#{Time.now.to_i}"
  end

  def requires_phone?
    pending_payment? && payment_method == 'MBW'
  end

  def valid_vat_id
    if vat_id.present?
      errors.add(:vat_id, :invalid) unless Valvat.new(read_attribute(:vat_id)).valid_checksum?
    end
  end

  def set_addon_bonus
    self.add_on_bonus = partner.add_on_value if has_add_on_partner?
  end
end
