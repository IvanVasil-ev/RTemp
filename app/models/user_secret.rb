# frozen_string_literal: true

class UserSecret < ApplicationRecord
  belongs_to :user
end
