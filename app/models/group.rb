class Group < ApplicationRecord
	has_many :memberships
	has_many :users, through: :memberships

	validates :name, presence: true

	def member?(user)
		self.users.include?(user.to_i)
	end

	def make_admin(user)
		membership = self.memberships.select{ |membership| membership.user_id == user.to_i }.first
		membership.update_attributes(trusted: true)
		membership.save
	end
	
	def remove_admin(user)
		membership = self.memberships.select{ |membership| membership.user_id == user.to_i }.first
		membership.update_attributes(trusted: false)
		membership.save
	end

	def admins
		self.memberships.select(&:trusted).collect(&:user_id)
	end

	def admin?(user)
		admins.include?(user.to_i)
	end

	def to_i
		self.id
	end

end
