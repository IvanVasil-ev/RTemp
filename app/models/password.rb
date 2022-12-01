# frozen_string_literal: true

class Password < ApplicationRecord
  acts_as_paranoid
  has_secure_password

  belongs_to :user
end
