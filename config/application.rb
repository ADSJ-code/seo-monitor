require_relative "boot"

# require "rails/all" # <= NÓS REMOVEMOS ISTO

# Inclua os frameworks que você precisa - pulando ActiveRecord
require "action_controller/railtie"
require "action_view/railtie"
require "action_mailer/railtie"
require "active_job/railtie"
require "action_cable/engine"
# require "active_storage/engine" # Já removemos em production.rb
require "action_text/engine"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SeoMonitor
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 8.0

    # Por favor, adicione o código de configuração que já existia no seu application.rb original
    # (ex: config.time_zone, etc.)
    # ...

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end