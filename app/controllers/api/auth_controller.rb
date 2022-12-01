# frozen_string_literal: true

module Api
  class AuthController < Api::ApplicationController
    def login
      data = Auth::LoginService.perform(login_params)

      if data
        app_cookies.set_tokens(data)
        redirect_to root_path
      else
        redirect_to login_path
      end
    end

    def registration
      data = Auth::RegistrationService.perform(registration_params)

      if data
        app_cookies.set_tokens(data)
        redirect_to login_path
      else
        redirect_to registration_path
      end
    end

    def logout
      token = app_cookies.get_cookies(:refresh_token)
      Auth::LogoutService.perform({ token:, current_user: @current_user })
      app_cookies.delete_tokens

      redirect_to login_path
    end

    def logout_all
      token = app_cookies.get_cookies(:refresh_token)
      Auth::LogoutService.perform({ token:, logout_all: true, current_user: @current_user })
      app_cookies.delete_tokens

      redirect_to login_path
    end

    private

    def login_params
      params.permit(:email, :password)
    end

    def registration_params
      params.permit(:email, :first_name, :last_name, :password, :avatar)
    end
  end
end
