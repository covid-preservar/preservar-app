# frozen_string_literal: true
FactoryBot.define do
  factory :seller do
    seller_user
    name { 'Tasca do Chico' }
    category
    address { "#{Faker::Address.street_name}, #{Faker::Address.building_number}" }
    area { Location.all.sample }

    factory :published_seller do
      published { true }
      payment_api_key { Faker::Internet.uuid }
      main_photo { Rack::Test::UploadedFile.new('spec/files/place-img.jpg', 'image/jpg') }
    end
  end

end
