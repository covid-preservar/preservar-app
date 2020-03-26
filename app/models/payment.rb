class Payment < ApplicationRecord
    belongs_to :voucher

    validates :method, presence: true, inclusion: { in: %w[MB MBW]}
    validates :value, presence: true, numericality: { min: 1 }
end
