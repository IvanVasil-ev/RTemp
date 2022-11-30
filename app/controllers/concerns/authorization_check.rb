# frozen_string_literal: true

module AuthorizationCheck
  extend ActiveSupport::Concern

  included do
    def check_authorization!
      redirect_to root_path if current_user && is_auth_controller?
      redirect_to login_path if !current_user && !is_auth_controller?
    end
  end

  private

  def current_user
    @current_user ||= request.env['current_user']
  end

  def is_auth_controller?
    controller_name == 'auth'
  end
end
