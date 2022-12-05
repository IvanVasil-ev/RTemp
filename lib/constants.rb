# frozen_string_literal: true

module Constants
  USER_ROLES = %i[user manager admin].freeze
  USER_ONLINE_STATUSES = %i[offline online].freeze

  COOKIES_DOMAIN = ENV.fetch('COOKIES_DOMAIN', 'localhost').freeze
  HASH_ALGORITHM = ENV.fetch('HASH_ALGORITHM', 'HS256').freeze
  ACCESS_TOKEN_EXP = ENV.fetch('ACCESS_TOKEN_EXP', '86400').to_i.freeze
  REFRESH_TOKEN_EXP = ENV.fetch('REFRESH_TOKEN_EXP', '604800').to_i.freeze
end
