module NotificationHelper
  def resolved(test)
    if test
      "Resolved"
    else
      "Requires Attention"
    end
  end
end
