# frozen_string_literal: true
class Voucher < ApplicationRecord
  PAYMENT_METHODS = %w[MB MBW].freeze

  include AASM

  aasm column: :state do
    state :created, initial: true
    state :pending_payment, :paid, :redeemed

    event :start_payment do
      transitions from: :created, to: :pending_payment, after: :generate_identifier
    end

    event :reset_payment do
      transitions from: :pending_payment, to: :created
    end

    event :payment_success do
      transitions from: :pending_payment, to: :paid, after: :generate_code
    end

    event :redeemed do
      transitions from: :paid, to: :redeemed
    end
  end

  belongs_to :seller

  validates :code, presence: true, uniqueness: { allow_nil: true }, if: :paid?
  validates :email, format: { with: Devise.email_regexp }, if: :pending_payment?
  validates :value, numericality: { minimum: 1 }
  validates :payment_method, presence: true,
                             inclusion: { in: PAYMENT_METHODS },
                             if: :pending_payment?

  validates :payment_identifier, presence: true, if: :pending_payment?
  validates :payment_phone, format: { with: /\A\d{9}\z/ }, if: :requires_phone?

  attr_reader :custom_value

  def custom_value=(val)
    self.value = val if val.present?
  end

  private

  def generate_code
    self.code = SecureRandom.hex(3).upcase
  end

  def generate_identifier
    self.payment_identifier = "s#{seller_id}v#{id}_#{payment_method.downcase}_#{Time.now.to_i}"
  end

  def requires_phone?
    pending_payment? && payment_method == 'MBW'
  end
end
