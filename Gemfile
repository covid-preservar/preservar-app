source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.5'

gem 'rails', '~> 6.0.2'
gem 'pg'

gem 'puma', '~> 4.3.3'
gem 'sassc-rails', '~> 2.1.0'
gem 'autoprefixer-rails'
gem 'webpacker', '~> 4.0'
gem 'turbolinks', '~> 5'
# gem 'jbuilder', '~> 2.7'
gem 'bootsnap', '>= 1.4.2', require: false

gem 'simple_form'
gem 'sidekiq', '~> 6.0.0'
gem 'devise'
gem 'devise-i18n'
gem 'slim-rails'
gem 'redcarpet'
gem 'gon'
gem 'friendly_id'
gem 'shrine'
gem 'image_processing', '~> 1.0'
gem 'image_optim'
gem 'geocoder'
gem 'maxminddb'
gem 'hive_geoip2'
gem 'pry'
gem 'faker'
gem 'rollbar'

# Backoffice
gem 'administrate', '~> 0.13.0'


group :production do
  gem 'scout_apm'
  gem 'dalli'
end

group :development, :test do
  gem 'pry-byebug'
  gem 'awesome_print'
  gem 'dotenv-rails'
  gem 'rspec-rails', '~> 3.9.0'
  gem 'factory_bot_rails'
  gem 'image_optim_pack'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'letter_opener_web'
  gem 'foreman', '= 0.86.0', :require => false
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  gem 'webdrivers'
  gem 'simplecov'
  gem 'database_cleaner'
  gem 'rspec-sidekiq'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
# gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
