namespace :db do
  desc 'Clear and populate database with demo data'
  task :populate => :environment do
    require 'faker'

    [AdminUser, Seller].each do |klass|

      query = "TRUNCATE TABLE #{klass.table_name} CASCADE"
      ActiveRecord::Base.connection.execute(query)

      # needed to reset id sequence in PostgreSQL
      ActiveRecord::Base.connection.reset_pk_sequence!(klass.table_name)

      # It seems that column information is not guaranteed to be up-to-date
      # when running populate.
      klass.reset_column_information
    end

    Seller.create!(name: 'Tasca do Chico',
                   category_id: 1,
                   city: 'Lisboa',
                   address:'R. Dr. José Ventura, 178')
    Seller.create!(name: 'Café Central',
                   category_id: 2,
                   city: 'Lisboa',
                   address:'Av. da República, 123')

    AdminUser.create!(email: 'admin@example.com', password: 'secret', confirmed_at: Time.now.utc)
  end
end
