# frozen_string_literal: true

module Auth
  class LogoutService < ApplicationService
    include Queries::UserListQuery

    def call
      # validate_params!

      return logout_all! unless logout_all.nil?

      logout!
    end

    private

    # def validate_params!
    #   raise Errors::Unauthorized if token.nil?
    #   raise Errors::Unauthorized unless current_user
    # end

    def logout!
      RefreshToken.find_by_token(token).destroy!
    end

    def logout_all!
      RefreshToken.where(user_id: current_user[:id]).destroy_all
      UserSecret.find_by_user_id(current_user[:id])
                .update!({ secret: SecureRandom.hex })
    end

    def logout_all
      params[:logout_all]
    end

    def token
      @token ||= params[:token]
    end
  end
end
