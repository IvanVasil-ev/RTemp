# frozen_string_literal: true

module Queries
  module UserListQuery
    extend ActiveSupport::Concern

    included do
      attr_reader :params
    end

    def user
      @user ||= find_user
    end

    def users
      @users ||= find_users
    end

    def deleted_user
      @deleted_user ||= find_only_deleted
    end

    def user_secret
      @user_secret ||= find_user_secret
    end

    private

    def find_user
      return @user = User.find_by_email(param_user_email) unless param_user_email.nil?
      return @user = User.find_by_id(param_post_user_id) unless param_post_user_id.nil?

      @user = User.find_by_id(param_user_id)
    end

    def find_users
      @users = pagination(User.order(:id))
    end

    def find_only_deleted
      return @deleted_user = User.only_deleted.find_by_email(param_user_id) unless param_user_email.nil?

      @deleted_user = User.only_deleted.find_by_id(param_user_id)
    end

    def param_post_user_id
      params[:user_id]
    end

    def param_user_email
      params[:email]
    end

    def param_user_id
      params[:id]
    end
  end
end
