# frozen_string_literal: true

class Cookies
  def initialize(context)
    @context = context
  end

  def get_cookies(name)
    @context.signed[name]
  end

  def set_cookies(name, value)
    @context.signed[name] = {
      value:,
      domain: Constants::COOKIES_DOMAIN,
      secure: Rails.env.production?,
      httponly: true
    }
  end

  def delete_cookies(name)
    @context.delete(name)
  end

  def set_tokens(data)
    set_cookies(:access_token, data[:access_token])
    set_cookies(:refresh_token, data[:refresh_token])
  end

  def delete_tokens
    delete_cookies(:access_token)
    delete_cookies(:refresh_token)
  end
end
