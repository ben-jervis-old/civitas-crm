module RostersHelper
	def users_string(users)
		if users.empty?
			return 'No members assigned'
		elsif users.count == 1
			return users.first.name
		elsif users.count == 2
			return "#{users.first.name} & #{users.second.name}"
		else
			return "#{users.first.name} + #{pluralize(users.count - 1, 'other')}"
		end
	end


end
