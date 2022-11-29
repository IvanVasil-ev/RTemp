# frozen_string_literal: true

module ApplicationHelper
  def current_path?(path = '')
    controller.controller_name == path.downcase
  end
end
