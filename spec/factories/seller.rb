# frozen_string_literal: true
FactoryBot.define do
  factory :seller do
    name { 'Tasca do Chico' }
    category
    payment_api_key { Faker::Internet.uuid }
    address { "#{Faker::Address.street_name}, #{Faker::Address.building_number}" }
    area { Location.all.sample }
  end
end
