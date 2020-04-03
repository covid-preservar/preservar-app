# frozen_string_literal: true
require 'rails_helper'

RSpec.describe SellerUser, type: :model do
  it 'has a valid factory' do
    expect(build(:seller_user)).to be_valid
  end
end
