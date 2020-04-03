namespace :db do
  desc 'Clear and populate database with demo data'
  task :populate => :environment do
    require 'faker'

    [AdminUser, Seller, SellerUser, Place].each do |klass|

      query = "TRUNCATE TABLE #{klass.table_name} CASCADE"
      ActiveRecord::Base.connection.execute(query)

      # needed to reset id sequence in PostgreSQL
      ActiveRecord::Base.connection.reset_pk_sequence!(klass.table_name)

      # It seems that column information is not guaranteed to be up-to-date
      # when running populate.
      klass.reset_column_information
    end
    place_hashes = [
      { name: 'Tasca do Chico', category_id: 1, area: 'Grande Lisboa' },
      { name: 'Tasca do Manel', category_id: 1, area: 'Grande Lisboa' },
      { name: 'Winery', category_id: 1, area: 'Grande Porto' },
      { name: 'Restaurante do Carlos', category_id: 1, area: 'Grande Porto' },
      { name: 'Bifanas', category_id: 1, area: 'Grande Porto' },
      { name: 'Cachorros', category_id: 1, area: 'Grande Porto' },
      { name: 'Green smoothies', category_id: 2, area: 'Grande Porto' },
      { name: 'Zero Zero', category_id: 1, area: 'Grande Lisboa' },
      { name: 'Suma Suma', category_id: 1, area: 'Grande Porto' }
    ]

    seed_cities = ['Grande Lisboa', 'Grande Porto', 'Coimbra', 'Faro']
    20.times do
      place_hashes << { name: Faker::Company.name, category_id: 1+rand(Category.count), area: seed_cities.sample }
    end


    place_hashes.each do |place_hash|
      next if Place.find_by(name: place_hash[:name]).present?

      puts 'Creating place...'
      seller = Seller.create!(payment_api_key:'demo-86fa-c41b-05e8-ad5',
                              company_name: Faker::Company.name,
                              contact_name: Faker::Name.name,
                              vat_id: '999999999',
                              seller_user: SellerUser.new(email: Faker::Internet.email, password:'secret'))

      params = place_hash.merge(address: "#{Faker::Address.street_name}, #{Faker::Address.building_number}",
                                published: true,
                                main_photo: Rack::Test::UploadedFile.new('spec/files/place-img.jpg', 'image/jpg'))

      seller.places.create!(params)
    end

    AdminUser.create!(email: 'admin@example.com', password: 'secret', confirmed_at: Time.now.utc)
  end
end

