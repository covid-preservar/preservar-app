# frozen_string_literal: true
class Partnership < ApplicationRecord
  belongs_to :partner, inverse_of: :partnerships
  belongs_to :place, inverse_of: :partnership
  belongs_to :partner_identifier, optional: true
end

