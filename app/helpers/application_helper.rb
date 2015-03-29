module ApplicationHelper
  def container_class
    "#{controller_name}-#{action_name}"
  end
end
