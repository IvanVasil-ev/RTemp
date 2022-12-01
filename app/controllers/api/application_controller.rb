# frozen_string_literal: true

module Api
  class ApplicationController < ActionController::API
    include ActionController::Cookies

    def app_cookies
      @app_cookies ||= ::Cookies.new(cookies)
    end
  end
end
