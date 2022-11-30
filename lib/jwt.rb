# fronzen_string_literal: true

class Jwt
  require 'jwt'

  class << self
    def vefiry!(token, hash_salt)
      HashWithIndifferentAccess.new(JWT.decode(token, hash_salt)[0])
    end

    def decode(token)
      HashWithIndifferentAccess.new(JWT.decode(token, nil, false)[0])
    end

    def generate(data, hash_salt)
      access_exp = Time.now.to_i + Lib::Constants::ACCESS_TOKEN_EXP
      refresh_exp = Time.now.to_i + Lib::Constants::REFRESH_TOKEN_EXP

      {
        access_token: encode(data, access_exp, hash_salt),
        refresh_token: encode(data, refresh_exp, hash_salt),
        refresh_exp: refresh_exp
      }
    end

    private

    def encode(data, exp, hash_salt)
      JWT.encode({ data:, exp: }, hash_salt, Lib::Constants::HASH_ALGORITHM)
    end
  end
end
