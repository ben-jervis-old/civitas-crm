module GroupsHelper
  def return_group_type (str = "")
    if str.blank?
      "No group Type assigned"
    else
      str
    end
  end

  def userlist_tooltip_string(user_list)
    if user_list.length == 0
      return "No members"
    elsif user_list.length < 6
      return user_list.join("\n")
    else
      return "#{(user_list[0..4]).join("\n")}\n+#{pluralize(user_list.length - 5, 'other')}"
    end
  end

  def return_description (str = "")
    if str.blank?
      "-"
    else
      str
    end
  end
end
