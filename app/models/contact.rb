class Contact < ApplicationRecord
#  has_one :creator
#  has_one :user, through: :creator
	has_and_belongs_to_many :users
end
