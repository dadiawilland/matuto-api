require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module MatutoApi
  class Application < Rails::Application
    config.api_only = true
    # config.middleware.use ActionDispatch::Cookies
    # config.middleware.use ActionDispatch::Session::CookieStore, key: '_namespace_key'
    # config.action_controller.forgery_protection_origin_check = false
    # config.middleware.use ActionDispatch::Flash
    # Initialize configuration defaults for originally generated Rails version.
    config.autoload_once_paths << "#{root}/app/services"
    config.autoload_once_paths << "#{root}/app/serializers"
    config.autoload_paths << "#{Rails.root}/lib"
    config.to_prepare do
      DeviseController.respond_to :html, :json
    end
    config.load_defaults 7.0

    config.after_initialize do
      require 'custom_token_response'
    end

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
