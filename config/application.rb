require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module RTemp
  class Application < Rails::Application
    config.load_defaults 7.0
    config.action_cable.url = "ws://localhost:3000/cable"

    config.action_mailer.preview_path = "#{config.root}/spec/mailers/previews"
    config.support_email = 'main@example.com'

    config.eager_load_paths += %W[#{config.root}/lib]
    config.autoload_paths += %W[#{config.root}/lib]
    config.autoload_paths += %W[#{config.root}/app/services]

    config.middleware.use ActionDispatch::Cookies
  end
end
