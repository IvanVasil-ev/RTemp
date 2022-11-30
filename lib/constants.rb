# frozen_strin_literal: true

module Lib::Constants
  COOKIES_DOMAIN = ENV.fetch('COOKIES_DOMAIN') { 'localhost' }.freeze
  HASH_ALGORITHM = ENV.fetch('HASH_ALGORITHM') { 'secret' }.freeze
  ACCESS_TOKEN_EXP = ENV.fetch('ACCESS_TOKEN_EXPIRATION') { 0 }.freeze
  REFRESH_TOKEN_EXP = ENV.fetch('REFRESH_TOKEN_EXPIRATION') { 0 }.freeze
end
