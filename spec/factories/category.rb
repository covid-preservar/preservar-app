# frozen_string_literal: true
FactoryBot.define do
  factory :category do
    name { Faker::Restaurant.type }
    name_plural {name.pluralize }
  end
end
