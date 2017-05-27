class Event < ApplicationRecord
	validates :title, 			presence: true
	validates :event_date, 	presence: true
	validates :location, 		presence: true

	def next_occurrence
		new_date = self.event_date + self.repeat
		Event.new(title: self.title, event_date: new_date, location: self.location, repeat: self.repeat)
	end
end
