# frozen_string_literal: true

module AuthorizationCheck
  extend ActiveSupport::Concern

  included do
    def check_authorization!
      redirect_to root_path if current_user && auth_controller?
      redirect_to login_path if !current_user && !auth_controller?
    end
  end

  private

  def auth_controller?
    controller_name == 'auth'
  end

  def app_cookies
    @app_cookies ||= ::Cookies.new(cookies)
  end

  def current_user
    @current_user ||= authenticate_user!
  end

  def authenticate_user!
    data = Jwt.verify!(access_token, user_secret)[:data]
    data
  rescue JWT::ExpiredSignature
    app_cookies.delete_cookies(:access_token)
    data = Jwt.verify!(refresh_token, user_secret)[:data]
    new_tokens = Jwt.generate(data, user_secret)
    db_refresh_token = RefreshToken.find_by_token(refresh_token)
    app_cookies.delete_tokens if db_refresh_token.nil?

    return nil if db_refresh_token.nil?

    db_refresh_token.update!({
      token: new_tokens[:refresh_token],
      expires_at: Time.at(new_tokens[:refresh_exp])
    })
    app_cookies.set_tokens(new_tokens)
    data

  rescue JWT::DecodeError
    app_cookies.delete_tokens

    nil
  end

  def user_id
    @user_id ||= Jwt.decode(access_token)[:data][:id]
  end

  def access_token
    @access_token ||= app_cookies.get_cookies(:access_token) || nil
  end

  def refresh_token
    @refresh_token ||= app_cookies.get_cookies(:refresh_token) || nil
  end

  def user_secret
    @user_secret ||= find_user_secret
  end

  def find_user_secret
    UserSecret.find_by_user_id(user_id).secret
  end
end
