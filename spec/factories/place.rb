# frozen_string_literal: true
FactoryBot.define do
  factory :place do
    seller
    name { 'Tasca do Chico' }
    category
    address { "#{Faker::Address.street_name}, #{Faker::Address.building_number}" }
    area { Location.all.sample }
    main_photo { Rack::Test::UploadedFile.new('spec/files/place-img.jpg', 'image/jpg') }

    factory :published_place do
      published { true }
    end
  end
end
