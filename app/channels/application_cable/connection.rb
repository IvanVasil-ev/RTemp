# frozen_string_literal: true

module ApplicationCable
  class Connection < ActionCable::Connection::Base
    include AuthorizationCheck

    identified_by :connected_user

    def connect
      self.connected_user = find_verified_user
    end

    private

    def find_verified_user
      return reject_unauthorized_connection unless current_user

      current_user
    end
  end
end
