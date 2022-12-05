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

  def path_name
    controller.controller_name.capitalize
  end

  def user_full_name(user)
    f_name = user[:first_name] || ''
    l_name = user[:last_name] || ''
    "#{f_name} #{l_name}"
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
