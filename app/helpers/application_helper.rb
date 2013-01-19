module ApplicationHelper
	def full_title(page_title)
		base_title="Small project before assign Jikeicloud "
		if page_title.empty?
			base_title
		else 
			"#{base_title} | #{page_title}"
		end
	end
end
