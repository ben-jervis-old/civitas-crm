module GroupsHelper
  def return_group_type (str = "")
    if str.blank?
      "No group Type assigned"
    else
      str
    end
  end
end
