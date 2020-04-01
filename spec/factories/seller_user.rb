# frozen_string_literal: true
FactoryBot.define do
  factory :seller_user do
    email { Faker::Internet.email }
    password { 'secret' }
  end
end
