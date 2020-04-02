# frozen_string_literal: true
class Seller < ApplicationRecord
  belongs_to :seller_user
  has_many :places

  validates :vat_id, :contact_name, :company_name, presence: true
end
