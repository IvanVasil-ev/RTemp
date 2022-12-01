# frozen_string_literal: true

module Auth
  class RegistrationService < ApplicationService
    def call
      # validate_params!

      registration
    end

    private

    # def validate_params!
    #   raise Errors::ParameterMissing, :email if params[:email].nil?
    #   raise Errors::ParameterMissing, :password if params[:password].nil?
    #   raise Errors::ParameterMissing, :first_name if params[:first_name].nil?
    #   raise Errors::ParameterMissing, :last_name if params[:last_name].nil?
    # end

    def registration
      user = User.new(params_create_user)
      User.transaction do
        user.save!
        user.avatar.attach(param_user_avatar) unless param_user_avatar.nil?
        UserSecret.create({
                            secret: SecureRandom.hex,
                            user_id: user.id
                          })
        Password.create({
                          password: params[:password].to_s,
                          user_id: user.id
                        })
      end
    end

    def param_user_avatar
      params[:avatar]
    end

    def params_create_user
      {
        email: params[:email],
        first_name: params[:first_name],
        last_name: params[:last_name]
      }
    end
  end
end
