module ApplicationHelper
  def title(value)
    unless value.nil?
      @title = "#{value} | Collegenotify"      
    end
  end
end
