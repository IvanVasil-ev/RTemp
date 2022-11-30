require_relative "boot"

require "rails/all"
require_relative '../app/middlewares/jwt_authorization_middleware'

Bundler.require(*Rails.groups)

module RTemp
  class Application < Rails::Application
    config.load_defaults 7.0

    config.eager_load_paths += %W[#{config.root}/lib]
    config.autoload_paths += %W[#{config.root}/lib]

    config.middleware.use ActionDispatch::Cookies
    config.middleware.use ::JwtAuthorizationMiddleware
  end
end
