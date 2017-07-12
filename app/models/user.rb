class User < ApplicationRecord
	attr_accessor :remember_token, :activation_token

	has_many :memberships
	has_many :groups, through: :memberships
	has_many :tasks
	has_many :rosters, through: :tasks

	has_secure_password

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	validates :first_name, 	presence: true, length: { maximum: 50 }
	validates :last_name, 	presence: true, length: { maximum: 50 }
	validates :email, 			presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
	validate 	:level_must_be_valid
	validates :password, presence: true, length: { minimum: 8 }

	before_save :check_level
	before_save :check_birthdate
	before_save { self.email = email.downcase }
	before_create :create_activation_digest

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

	def remember
		self.remember_token = User.new_token
		update_attribute(:remember_digest, User.digest(remember_token))
	end

	def authenticated?(remember_token)
		return false if remember_digest.nil?
		BCrypt::Password.new(remember_digest).is_password?(remember_token)
	end

	def forget
		update_attribute(:remember_digest, nil)
	end

	def User.digest(string)
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
		BCrypt::Password.create(string, cost: cost)
	end

	def User.new_token
		SecureRandom.urlsafe_base64
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

		def create_activation_digest
			self.activation_token = User.new_token
			self.activation_digest = User.digest(activation_token)
		end
end
