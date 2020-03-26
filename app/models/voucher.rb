# frozen_string_literal: true
class Voucher < ApplicationRecord
  include AASM

  aasm column: :state do
    state :created, initial: true
    state :pending_payment, :paid, :redeemed

    event :start_payment do
      transitions from: :created, to: :pending_payment
    end

    event :payment_success do
      transitions from: :pending_payment, to: :paid, after: :generate_code
    end

    event :redeemed do
      transitions from: :paid, to: :redeemed
    end
  end

  belongs_to :seller
  has_one :payment

  validates :code, presence: true, uniqueness: { allow_nil: true }, if: :paid?
  validates :value, numericality: { minimum: 1 }

  attr_reader :custom_value

  def custom_value=(val)
    self.value = val if val.present?
  end

  private

  def generate_code
    self.code = SecureRandom.hex(4).upcase
  end
end
