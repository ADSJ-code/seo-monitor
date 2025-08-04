# spec/rails_helper.rb
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'

abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
require 'mongoid-rspec'

RSpec.configure do |config|
  config.include Mongoid::Matchers, type: :model

  # Limpa a base de dados de teste antes de cada execução
  config.before(:suite) do
    Mongoid.purge!
  end
end