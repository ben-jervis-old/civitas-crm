module ApplicationHelper

	def full_title(page_title = '')
		base_title = "civitasCRM"
		if page_title.empty?
			base_title
		else
			page_title + " | " + base_title
		end
	end

	def date_as_local(date)
		date.in_time_zone('Sydney').strftime("%d/%m/%Y")
	end
end
