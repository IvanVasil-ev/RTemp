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
    Jwt.verify!(access_token, user_secret)[:data]

  rescue JWT::ExpiredSignature
    @cookies.delete_cookies(:access_token)
    data = Jwt.verify!(refresh_token, user_secret)[:data]
    new_tokens = Jwt.generate(data, user_secret)
    db_refresh_token = RefreshToken.find_by_token(refresh_token)
    @cookies.delete_tokens if db_refresh_token.nil?

    return nil if db_refresh_token.nil?

    db_refresh_token.update!({
      token: new_tokens[:refresh_token],
      expires_at: Time.at(new_tokens[:refresh_exp])
    })
    @cookies.set_tokens(new_tokens)
    data

  rescue JWT::DecodeError
    @cookies.delete_tokens

    nil
  end

  def user_id
    @user_id ||= Jwt.decode(access_token)[:data][:id]
  end

  def access_token
    @access_token ||= @cookies.get_cookies(:access_token) || nil
  end

  def refresh_token
    @refresh_token ||= @cookies.get_cookies(:refresh_token) || nil
  end

  def user_secret
    @user_secret ||= find_user_secret
  end

  def find_user_secret
    UserSecret.find_by_user_id(user_id).secret
  end
end
