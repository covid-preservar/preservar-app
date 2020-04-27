# frozen_string_literal: true
class Seller < ApplicationRecord
  belongs_to :seller_user
  has_many :places, dependent: :restrict_with_exception
  has_many :vouchers, through: :places

  validates :vat_id, :contact_name, :company_name, presence: true

  before_validation :sanitize_vat_id
  before_validation :normalize_iban

  def to_s
    "Seller ##{id}: #{company_name}"
  end

  private

  def sanitize_vat_id
    self.vat_id.tr!(' ', '')
  end

  def normalize_iban
    self.iban = Ibandit::IBAN.new(self.iban).to_s(:formatted) if self.iban.present?
  end
end
