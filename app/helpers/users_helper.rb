module UsersHelper
  def pad_number (num = 0)
    if num.to_s.length == 9
      "0" + num.to_s
    else
      num.to_s
    end
  end
  
  def format_number (num = 0)
    num = pad_number(num)
    if num[1].to_i == 4
      "#{num[0..3]} #{num[4..6]} #{num[7..9]}"
    else
      "(#{num[0..1]}) #{num[2..5]} #{num[6..9]}"
    end
  end
  
  
end
