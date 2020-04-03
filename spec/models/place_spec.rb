# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Place, type: :model do
  it 'has a valid factory' do
    expect(build(:place)).to be_valid
  end

  it 'cannot be published without a payment API key' do
    place = build(:published_place)
    expect(place).to be_valid

    place.seller.payment_api_key = nil
    expect(place).not_to be_valid
  end
end
