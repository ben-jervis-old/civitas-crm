class Task < ApplicationRecord
	has_many :assignments
	has_many :users, through: :assignments
	belongs_to :roster

	validates :roster_id, presence: true
	validates :title, 		presence: true
	validates :due, 			presence: true
end
