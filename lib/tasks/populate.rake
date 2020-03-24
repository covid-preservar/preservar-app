namespace :db do
  desc 'Clear and populate database with demo data'
  task :populate => :environment do
    require 'faker'

    [AdminUser, User, Seller].each do |klass|

      query = "TRUNCATE TABLE #{klass.table_name} CASCADE"
      ActiveRecord::Base.connection.execute(query)

      # needed to reset id sequence in PostgreSQL
      ActiveRecord::Base.connection.reset_pk_sequence!(klass.table_name)

      # It seems that column information is not guaranteed to be up-to-date
      # when running populate.
      klass.reset_column_information
    end
    seller_hash = [
      { name: 'Tasca do Chico', category_id: 1, city: 'Lisboa' },
      { name: 'Tasca do Manel', category_id: 1, city: 'Lisboa' },
      { name: 'Winery', category_id: 1, city: 'Porto' },
      { name: 'Restairante do Carlos', category_id: 1, city: 'Porto' },
      { name: 'Bifanas', category_id: 1, city: 'Porto' },
      { name: 'Cachorros', category_id: 1, city: 'Porto' },
      { name: 'Green smoothies', category_id: 1, city: 'Porto' },
      { name: 'Zero Zero', category_id: 1, city: 'Lisboa' },
      { name: 'Suma Suma', category_id: 1, city: 'Porto' }
    ]

    seller_hash.each do |seller_hash|
      next if Seller.find_by(name: seller_hash[:name]).present?

      puts 'Creating seller...'
      
      Seller.create!(name: seller_hash[:name], category_id: 1, city: seller_hash[:city] )
    end

    user_hashes = [
      { name: 'Joe User', email: 'joeuser@example.com', password: 'secret'}
    ]


    user_hashes.each do |user_hash|
      next if User.find_by(email: user_hash[:email]).present?

      puts "creating User: #{user_hash[:email]} ; PW: #{user_hash[:password]}"
      user = User.new(email: user_hash[:email],
                      password: user_hash[:password],
                      password_confirmation: user_hash[:password])
      # user.skip_confirmation!

      user.save(validate: false)
    end

    AdminUser.create!(email: 'admin@example.com', password: 'secret', confirmed_at: Time.now.utc)
  end
end
