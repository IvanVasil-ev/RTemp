# frozen_string_literal: true

class JwtAuthorizationMiddleware
  def initialize(app)
    @app ||= app
  end

  def call(env)
    request = ActionDispatch::Request.new(env)
    @cookies = ::Cookies.new(request.cookie_jar)
    dispatch(env)
    @app.call(env)
  end

  def dispatch(env)
    env['current_user'] = current_user
  end

  private

  def current_user
    @current_user ||= authenticate_user!
  end

  def authenticate_user!
    # TODO: get user from JWT
    {}
  end
end
