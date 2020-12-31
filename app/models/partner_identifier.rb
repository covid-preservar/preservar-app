# frozen_string_literal: true
class PartnerIdentifier < ApplicationRecord

  belongs_to :partner
  has_many :partnerships

  def mark_used!
    update! last_used_at: Time.now, use_count: use_count + 1
  end
end
