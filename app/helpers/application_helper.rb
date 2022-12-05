# frozen_string_literal: true

module ApplicationHelper
  def current_path?(path = '')
    controller.controller_name == path.downcase
  end

  def full_title(page_title = '')
    base_title = 'RTemp'
    if page_title.present?
      "#{page_title} | #{base_title}"
    else
      "#{controller.controller_name.capitalize} | #{base_title}"
    end
  end

  def set_header?(state = false)
    !state
  end

  def log_in?
    @current_user.present?
  end

  def path_name(page_header_title = '')
    if page_header_title.present?
      page_header_title
    else
      controller.controller_name.capitalize
    end
  end

  def online_status_to_color(status)
    case status
    when 'online'
      'text-green'
    when 'offline'
      'text-red'
    else
      'text-gray'
    end
  end
end
