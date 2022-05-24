# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.4'

gem 'rails', '~> 6.1.0'
gem 'pg'

gem 'puma', '~> 5.6.2'
gem 'sassc-rails', '~> 2.1.0'
gem 'autoprefixer-rails'
gem 'webpacker', '~> 5.2'
gem 'turbolinks', '~> 5'
# gem 'jbuilder', '~> 2.7'
gem 'bootsnap', '>= 1.4.2', require: false

gem 'aasm'
gem 'aws-sdk-s3'
gem 'cancancan'
gem 'countries'
gem 'devise-i18n'
gem 'devise'
gem 'faker', require: false
gem 'flipper'
gem 'flipper-ui'
gem 'flipper-active_record'
gem 'friendly_id'
gem 'geocoder'
gem 'gon'
gem 'groupdate'
gem 'ibandit'
gem 'image_optim'
gem 'image_processing', '~> 1.0'
gem 'inline_svg'
gem 'kaminari'
gem 'maxminddb'
gem 'meta-tags'
gem 'nokogiri', '~> 1.13.6'
gem 'premailer-rails'
gem 'pry'
gem 'pry-rails'
gem 'rails-i18n', '~> 6.0.0'
gem 'rack-cors'
gem 'ransack'
gem 'redcarpet'
gem 'rest-client'
gem 'rexml'
gem 'rollbar'
gem 'shrine'
gem 'sidekiq', '~> 6.4.0'
gem 'sidekiq-cron'
gem 'sidekiq-throttled'
gem 'slim-rails'
gem 'valvat'

# Forms and validations - order matters here
gem 'simple_form'
gem 'client_side_validations'
gem 'client_side_validations-simple_form'

group :production do
  gem 'cloudflare-rails'
  gem 'dalli'
  gem 'scout_apm', github:'scoutapp/scout_apm_ruby', branch: 'ruby-3'
end

group :development, :test do
  gem 'awesome_print'
  gem 'dotenv-rails'
  gem 'factory_bot_rails'
  gem 'image_optim_pack'
  gem 'pry-byebug'
  gem 'rspec-rails', '~> 5.0.0'
end

group :development do
  gem 'bullet'
  gem 'foreman', '= 0.87.1', require: false
  gem 'letter_opener_web'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'spring'
  gem 'web-console', '>= 3.3.0'
  gem 'rubocop'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'database_cleaner'
  gem 'rspec-sidekiq'
  gem 'selenium-webdriver'
  gem 'simplecov'
  gem 'webdrivers'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
# gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
