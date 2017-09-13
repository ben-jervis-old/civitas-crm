class Event < ApplicationRecord
	validates :title, 			presence: true
	validates :event_date, 	presence: true
	validates :location, 		presence: true

	attr_accessor :event_time

	def next_occurrence
		new_event = self.clone
		new_date = self.event_date + self.repeat.days
		new_event.event_date = new_date
		return new_event
	end
end
