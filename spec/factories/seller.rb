# frozen_string_literal: true
FactoryBot.define do
  factory :seller do
    name { 'Tasca do Chico' }
    category
    average_value_per_person { 10 }
    payment_api_key { 'asdfgh123425' }
  end
end
