module ApplicationHelper
  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    current = current_user.id
    link_to title, {:sort => column, :direction => direction, :user_id=> current}, {:class => css_class}
  end



def avatar(user)
    if user.avatar.present?
      user.avatar
    else
      default_url = "#{root_url}images/default_avatar.gif"
      # gravatar_id = Digest::MD5::hexdigest(user.email).downcase
      # "http://gravatar.com/avatar/#{gravatar_id}.png?s=48&d=#{CGI.escape(default_url)}"
    end
  end


end
