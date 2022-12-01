# frozen_string_literal: true

# fronzen_string_literal: true

class Jwt
  require 'jwt'

  class << self
    def verify!(token, hash_salt)
      HashWithIndifferentAccess.new(JWT.decode(token, hash_salt)[0])
    end

    def decode(token)
      HashWithIndifferentAccess.new(JWT.decode(token, nil, false)[0])
    end

    def generate(data, hash_salt)
      access_exp = Time.now.to_i + Constants::ACCESS_TOKEN_EXP
      refresh_exp = Time.now.to_i + Constants::REFRESH_TOKEN_EXP

      {
        access_token: encode(data, access_exp, hash_salt),
        refresh_token: encode(data, refresh_exp, hash_salt),
        refresh_exp:
      }
    end

    private

    def encode(data, exp, hash_salt)
      JWT.encode({ data:, exp: }, hash_salt, Constants::HASH_ALGORITHM)
    end
  end
end
