module ApplicationHelper
  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    current = current_user.id
    link_to title, {:sort => column, :direction => direction, :user_id=> current}, {:class => css_class}
  end
end
