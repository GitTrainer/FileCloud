module ApplicationHelper
	def sortable(column, title = nil)
	  	title ||= column.titleize
	 	css_class = column == sort_column ? "current #{sort_direction}" : nil
	  	direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
	  	link_to title, params.merge(:sort => column, :direction => direction, :page => nil), {:class => css_class}
	end
	def set_mailer_host
	    ActionMailer::Base.default_url_options[:host] = request.host_with_port
	end
end
