# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include AuthorizationCheck

  before_action :check_authorization!
end
