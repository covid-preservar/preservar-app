require 'rails_helper'

RSpec.describe Seller, type: :model do
  it 'has a valid factory' do
    expect(build(:seller)).to be_valid
  end

end