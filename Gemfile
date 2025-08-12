source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.3.3"

gem "rails", "~> 8.0.2"

# Nossas Gems Customizadas
gem 'mongoid', '~> 8.0'
gem 'google_search_results'
gem 'sidekiq'
gem 'redis'

# Gems Padrão do Rails
gem "propshaft"
gem "puma", ">= 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"
gem "bootsnap", require: false
gem "tzinfo-data", platforms: %i[ windows jruby ]

group :development, :test do
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "rspec-rails", "~> 8.0"
  gem "mongoid-rspec"
end

group :development do
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
end