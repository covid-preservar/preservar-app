namespace :db do
  desc 'Clear and populate database with demo data'
  task :populate => :environment do
    require 'faker'

    [AdminUser, Seller, SellerUser].each do |klass|

      query = "TRUNCATE TABLE #{klass.table_name} CASCADE"
      ActiveRecord::Base.connection.execute(query)

      # needed to reset id sequence in PostgreSQL
      ActiveRecord::Base.connection.reset_pk_sequence!(klass.table_name)

      # It seems that column information is not guaranteed to be up-to-date
      # when running populate.
      klass.reset_column_information
    end
    seller_hash = [
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
      seller_hash << { name: Faker::Company.name, category_id: 1+rand(Category.count), area: seed_cities.sample }
    end

    seller_hash.each do |seller_hash|
      next if Seller.unscoped.find_by(name: seller_hash[:name]).present?

      puts 'Creating seller...'
      params = seller_hash.merge(address: "#{Faker::Address.street_name}, #{Faker::Address.building_number}",
                                 seller_user: SellerUser.new(email: Faker::Internet.email, password:'secret'),
                                 published: true)
      Seller.new(params).save(validate: false)
    end

    AdminUser.create!(email: 'admin@example.com', password: 'secret', confirmed_at: Time.now.utc)
  end
end

