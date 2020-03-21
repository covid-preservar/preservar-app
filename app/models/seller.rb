class Seller < ApplicationRecord
  belongs_to :category
  has_many :vouchers
end
