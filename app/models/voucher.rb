class Voucher < ApplicationRecord
  include AASM

  aasm column: :state do
    state :pending, initial: true
    state :paid, :redeemed

    event :payment_success do
      transitions from: :pending, to: :paid, after: :generate_code
    end

    event :redeemed do
      transitions from: :paid, to: :redeemed
    end
  end

  belongs_to :seller

  validates :code, presence: true, uniqueness: {allow_nil: true}, unless: :pending?

  private

  def generate_code
    self.code = SecureRandom.hex(4).upcase
  end
end