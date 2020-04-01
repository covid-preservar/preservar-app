# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Seller, type: :model do
  it 'has a valid factory' do
    expect(build(:seller)).to be_valid
  end

  it 'cannot be published without a payment API key' do
    seller = build(:published_seller)
    expect(seller).to be_valid

    seller.payment_api_key = nil
    expect(seller).not_to be_valid
  end

  it 'cannot be published without a photo' do
    seller = create(:published_seller)
    expect(seller).to be_valid

    seller.update main_photo: nil
    expect(seller).not_to be_valid
  end

end
