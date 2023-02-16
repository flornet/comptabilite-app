require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ComptaApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    config.i18n.available_locales = :fr
    config.i18n.default_locale = :fr
    config.time_zone = "Europe/Paris"
    # config.active_support.disable_to_s_conversion = false
    
    # config.active_record.yaml_column_permitted_classes = [Symbol]
    # config.active_record.use_yaml_unsafe_load = true
    # config.active_record.yaml_column_permitted_classes = [ActiveSupport::HashWithIndifferentAccess]
  end
end
