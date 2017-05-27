class Task < ApplicationRecord
	belongs_to :user
	belongs_to :roster

	validates :roster_id, presence: true
	validates :user_id, 	presence: true
	validates :title, 		presence: true
	validates :due, 			presence: true
end
