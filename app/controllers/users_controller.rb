# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show; end

  def me; end

  def delete_selected
    ids = params[:id].split(',')
    users = User.where(id: ids)

    return if ids.blank?

    users.each(&:destroy!)
    render js: "window.location = '/users'"
  end
end
