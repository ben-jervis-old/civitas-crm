class Event < ApplicationRecord
	validates :title, 			presence: true
	validates :event_date, 	presence: true
	validates :location, 		presence: true

	attr_accessor :event_time

	has_many :attendances, dependent: :destroy
	has_many :users, -> { distinct }, through: :attendances

	def next_occurrence
		new_date = self.event_date + self.repeat.days
		new_event = Event.new(title: self.title, event_date: new_date, location: self.location, repeat: self.repeat, event_type: self.event_type)
		return new_event
	end

	def formatted_date
		self.event_date.localtime.strftime("%d/%m/%Y")
	end

	def formatted_next
		(self.event_date.localtime + self.repeat.days).strftime("%d/%m/%Y")
	end

	def formatted_time
		event_date.localtime.strftime("%I:%M%P")
	end

	def event_time
		self.event_date.to_time.localtime
	end
end
