class User < ApplicationRecord
	has_many :memberships
	has_many :groups, through: :memberships
	has_many :tasks
	has_many :rosters, through: :tasks

	validates :first_name, 	presence: true, length: { maximum: 50 }
	validates :last_name, 	presence: true, length: { maximum: 50 }
	validates :email, 			presence: true, length: { maximum: 255 }
	validate 	:level_must_be_valid

	before_save :check_level
	before_save :check_birthdate

	has_secure_password

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

	def admin_of
		self.memberships.select(&:trusted).collect(&:group_id)
	end

	def admin_of?(group)
		self.admin_of.include?(group.to_i)
	end

	def add_to(groups, opts = { trusted: false })
		groups = [groups] unless groups.is_a?(Array)
		groups.each do |group|
			self.memberships.create(group_id: group.to_i, trusted: opts[:trusted])
		end
	end

	def remove_from(groups)
		groups = [groups] unless groups.is_a?(Array)
		groups.each do |group|
			self.memberships.select{ |mem| mem.group_id ==  group.to_i }.first.destroy
		end
	end

	def make_admin(group)
		self.memberships.select{ |mem| mem.group_id == group.to_i }.first.update_attributes(trusted: true)
	end

	def User.digest(string)
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
		BCrypt::Password.create(string, cost: cost)
	end

	private
		def check_level
			self.level.downcase!
		end

		def check_birthdate
		end

		def level_must_be_valid
			if self.level.nil?
				errors.add(:level, "can't be blank")
			elsif !(%w(staff leader trusted member visitor).include?(self.level.downcase))
				errors.add(:level, "must be one of [staff, leader, trusted, member, visitor]")
			end
		end
end
