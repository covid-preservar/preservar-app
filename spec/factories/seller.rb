# frozen_string_literal: true
FactoryBot.define do
  factory :seller do
    name { 'Tasca do Chico' }
    category
    payment_api_key { 'asdfgh123425' }
  end
end
