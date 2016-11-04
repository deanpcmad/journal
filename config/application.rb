require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Journal
  class Application < Rails::Application
    config.autoload_paths += %W(#{config.root}/lib)
    config.generators do |g|
      g.orm             :active_record
      g.stylesheets     false
      g.javascripts     false
      g.helper          false
      g.test_framework  :rspec, spec: true, fixture: false
    end

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
