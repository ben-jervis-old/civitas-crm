class User < ApplicationRecord

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
	end
end
