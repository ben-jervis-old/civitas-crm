class Message < ApplicationRecord
	belongs_to :sender, class_name: "User"
	has_one :receiver, class_name: "User", foreign_key: "receiver_id"
end
