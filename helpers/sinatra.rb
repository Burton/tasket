helpers do
  def logged_in?
    return true if session[:user]
    nil
  end

  def logged_in_user
    return session[:user] if logged_in?
    nil
  end

  def link_to(name, location, alternative = false)
    if alternative and alternative[:condition]
      "<a href=#{alternative[:location]}>#{alternative[:name]}</a>"
    else
      "<a href=#{location}>#{name}</a>"
    end
  end

  def random_string(len)
   chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
   str = ""
   1.upto(len) { |i| str << chars[rand(chars.size-1)] }
   return str
  end

  def flash(msg)
    session[:flash] = msg
  end

  def show_flash
    if session[:flash]
      tmp = session[:flash]
      session[:flash] = false
      "<div class=\"flash_msg\"><h2>Notice</h2><p>#{tmp}</p></div>"
    end
  end
  
  
  def human_date(datetime)
    datetime.strftime('%d/%m/%Y').gsub(/ 0(\d{1})/, ' /1')
  end
  
  def partial(page, options={})
    erb page, options.merge!(:layout => false)
  end
  
  
end