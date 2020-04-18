# frozen_string_literal: true
class Seller < ApplicationRecord
  belongs_to :seller_user
  has_many :places, dependent: :restrict_with_exception
  has_many :vouchers, through: :places

  validates :vat_id, :contact_name, :company_name, presence: true

  before_validation :sanitize_vat_id

  private

  def sanitize_vat_id
    self.vat_id.tr!(' ', '')
  end
end
