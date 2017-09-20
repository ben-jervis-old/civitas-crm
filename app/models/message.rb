class Message < ApplicationRecord
	belongs_to :sender, class_name: "User"
	
	has_many :message_receivers 
    has_many :receivers , through: :message_receivers
	
end
