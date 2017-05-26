class Group < ApplicationRecord
	has_many :memberships
	has_many :users, through: :memberships
	validates :name, presence: true

	def member?(user)
		self.users.include?(user.to_i)
	end

	def trusted?(user)
		self.memberships.select(&:trusted).collect(&:user_id).include?(user.to_i)
	end

	def to_i

end
