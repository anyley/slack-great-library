require_relative 'boot'

require './config/secrets.rb'

require 'rails/all'
require 'sprockets/es6'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SlackLibrary
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    # config.i18n.enforce_available_locales = true
    config.i18n.default_locale = :ru
    config.i18n.locale = :ru
  end
end