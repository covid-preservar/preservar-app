# frozen_string_literal: true
class PartnerIdentifier < ApplicationRecord

  belongs_to :partner
  belongs_to :place, optional: true

  scope :unused, -> { where( used: false )}

  def mark_used!(place:)
    self.update! used: true, place: place, used_at: Time.now
  end
end
