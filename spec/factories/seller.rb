# frozen_string_literal: true
FactoryBot.define do
  factory :seller do
    seller_user
    payment_api_key { Faker::Internet.uuid }
    vat_id { '999999999' }
    company_name { Faker::Company.name }
    contact_name { Faker::Name.name }
  end
end
