module EventsHelper
	def time_string(event)
		if event.event_date.localtime < Time.now.localtime
			if ((Time.now.localtime - event.event_date.localtime) / 1.day) < 1
				time_string = "started #{distance_of_time_in_words(Time.now.localtime, event.event_date.localtime)} ago"
			else
				time_string = "#{distance_of_time_in_words(Time.now.localtime, event.event_date.localtime)} ago"
			end
		else
			time_string = "#{distance_of_time_in_words(Time.now.localtime, event.event_date.localtime)} from now"
		end

		time_string
	end
end
