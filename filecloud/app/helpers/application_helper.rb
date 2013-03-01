module ApplicationHelper
  def sortable(column, title = nil)

    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    # current = current_user.id
    link_to title, params.merge(:sort => column, :direction => direction, :page => nil), {:class => css_class}
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


    def public(search_folder)
      # binding.pry
       @search_folder = Folder.find(search_folder)
         if @search_folder.status=="t"
           return true
         end
    end



end


