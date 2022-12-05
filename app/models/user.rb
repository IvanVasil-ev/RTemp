# frozen_string_literal: true

class User < ApplicationRecord
  acts_as_paranoid

  has_many :refresh_tokens, dependent: :destroy
  has_one :password, dependent: :destroy
  has_one :user_secret, dependent: :destroy

  validates :email, uniqueness: true

  enum role: Constants::USER_ROLES

  def full_name
    f_name = first_name || ''
    l_name = last_name || ''
    "#{f_name} #{l_name}"
  end
end
