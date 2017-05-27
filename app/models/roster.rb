class Roster < ApplicationRecord
	has_many :tasks
	has_many :users, through: :tasks
	
	validates :title, presence: true
	validate  :must_start_after_today

	#TODO Implement once contact system is running
	# def notify
	# end

	def clone
		new_start_date = self.start_date + 7*self.duration
		new_roster = Roster.new(title: self.title, start_date: new_start_date, duration: self.duration)
		new_roster.save
		#TODO Task allocation
	end



	private
		def must_start_after_today
			if self.start_date <= Date.today
				errors.add(:start_date, "must be in the future (after today)")
			end
		end
end
