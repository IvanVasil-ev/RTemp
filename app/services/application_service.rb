# frozen_string_literal: true

class ApplicationService
  def self.perform(params = {}, &block)
    new(params).call(&block)
  end

  def initialize(params = {})
    @params = params.except(:current_user)
    @current_user ||= params[:current_user]
  end

  def call; end

  private

  attr_reader :params, :current_user
end
