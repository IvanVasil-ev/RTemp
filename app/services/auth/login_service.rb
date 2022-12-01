# frozen_string_literal: true

module Auth
  class LoginService < ApplicationService
    include Queries::UserListQuery

    def call
      return false unless validate_params!

      login
    end

    private

    def validate_params!
      # raise Errors::ParameterMissing, :email if param_user_email.nil?
      # raise Errors::ParameterMissing, :password if param_user_password.nil?
      return unless user
      return unless user.password.authenticate(param_user_password)

      true
    end

    def login
      tokens = Jwt.generate({ id: user.id, email: user.email, role: user.role }, user_secret)
      token = RefreshToken.new(
        token: tokens[:refresh_token],
        expires_at: Time.now + Constants::REFRESH_TOKEN_EXP,
        user_id: user.id
      )
      RefreshToken.transaction do
        token.save!
        tokens
      end
    end

    def user_secret
      @user_secret ||= user.user_secret.secret
    end

    def param_user_password
      params[:password]
    end
  end
end
