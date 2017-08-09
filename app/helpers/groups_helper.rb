module GroupsHelper
  def return_group_type (str = "")
    if str.blank?
      "No group Type assigned"
    else
      str
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
