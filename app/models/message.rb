class Message < ApplicationRecord
#  has_one :creator
#  has_one :user, through: :creator
	belongs_to :user
	has_many :recipients, class_name: User
	
end
