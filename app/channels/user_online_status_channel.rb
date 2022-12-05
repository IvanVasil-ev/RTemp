# frozen_string_literal: true

class UserOnlineStatusChannel < ApplicationCable::Channel
  def subscribed
    # Add redis container to get/set online status
  end

  def unsubscribed
    # Add redis container to get/set online status
  end
end
