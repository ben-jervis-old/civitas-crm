class Event < ApplicationRecord
	validates :title, 			presence: true
	validates :event_date, 	presence: true
	validates :location, 		presence: true

	has_many :attendances, dependent: :destroy
	has_many :users, -> { distinct }, through: :attendances

	def next_occurrence
		new_event = self.clone
		new_date = self.event_date + self.repeat.days
		new_event.event_date = new_date
		return new_event
	end

	def formatted_date
		self.event_date.in_time_zone('Sydney').strftime("%d/%m/%Y")
	end

	def formatted_time
		event_date.in_time_zone('Sydney').strftime("%I:%M%P")
	end

	def event_time
		self.event_date.to_time.in_time_zone('Sydney')
	end
end
