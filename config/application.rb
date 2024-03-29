require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module StckClinic
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # extra autoloads
    #config.autoload_paths += Dir[Rails.root.join('lib', '{**/}')]
    #    require_dependency(Rails.root.join('lib', 'import', '*.rb').to_s)
    #config.autoload_paths += Dir["#{config.root}/lib/**/"]
    #config.autoload_paths += Dir["#{config.root}/lib/**/"]
    Dir[Rails.root.join('lib', '**').to_s].each do |path|
      config.autoload_paths += [path]
    end
    #config.autoload_paths += %W(#{config.root}/lib)


    config.i18n.enforce_available_locales = true
  end
end
