class User < ApplicationRecord
	has_many :memberships
	has_many :groups, through: :memberships

	validates :first_name, 	presence: true
	validates :last_name, 	presence: true
	validates :email, 			presence: true
	validate :level_must_be_valid

	before_save :check_level

	# TODO has_secure_password

	def to_i
		self.id
	end

	def name
		"#{self.first_name} #{self.last_name}"
	end

	def staff?
		self.level == "staff"
	end

	def leader?
		self.level == "leader"
	end

	def trusted?
		self.level == "trusted"
	end

	def member?
		self.level == "member"
	end

	def visitor?
		self.level == "visitor"
	end

	# TODO Uncomment these once groups are implemented
	# def add_to(*groups)
	# 	groups.each{ |grp_num| self.memberships.create(group_id: grp_num) }
	# end
	#
	# def leader_of
	# 	self.groups.select{ |grp| grp.leader_id == self.id }
	# end
	#
	# def leader_of?(grp)
	# 	grp.leader_id == self.id
	# end

	private
		def check_level
			self.level.downcase!
		end

		def level_must_be_valid
			if self.level.nil?
				errors.add(:level, "can't be blank")
			elsif !(%w(staff leader trusted member visitor).include?(self.level.downcase))
				errors.add(:level, "must be one of [staff, leader, trusted, member, visitor]")
			end
		end
end
