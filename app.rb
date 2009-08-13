require 'rubygems'
require 'fileutils'
require 'sinatra'
require 'json'
require 'haml'


require 'config/database'
require 'helpers/sinatra'


## CONFIGURATION
enable :sessions

set :views, File.dirname(__FILE__) + '/views'
set :public, File.dirname(__FILE__) + '/public'

#@env["HTTP_X_REQUESTED_WITH"] == "XMLHttpRequest" 

mime :json, "application/json"

before do
  if logged_in?
    @new_tasks = Task.all(:tasked_id => logged_in_user.id).count(:status => 0)
    @tasked = Task.all(:tasked_by_id => logged_in_user.id, :tasked_id.not => logged_in_user.id).count(:status => 0)
  end
end


## ROUTING
enable :sessions

get '/' do
  @u = session[:user]
  haml :index
end

get '/user/login' do
  haml :'users/login'
end

post '/user/login' do
  if session[:user] = User.authenticate(params["login"], params["password"])
    flash("Login successful")
    redirect '/'
  else
    flash("Login failed - Try again")
    redirect '/user/login'
  end
end

get '/user/logout' do
  session[:user] = nil
  flash("Logout successful")
  redirect '/'
end

get '/user/create' do
  haml :'users/create'
end

post '/user/create' do
  u = User.new
  u.login = params["login"]
  u.password = params["password"]
  u.email = params["email"]
  if u.save
    flash("User created")
    redirect '/users/list'
  else
    tmp = []
    u.errors.each do |e|
      tmp << (e.join("<br/>"))
    end
    flash(tmp)
    redirect '/user/create'
  end
end

get '/user/account' do
  if logged_in?
    @user = logged_in_user
    haml :'users/account'
  else 
    flash("you need to log in to manage your account, existing or otherwise.")
    redirect '/'
  end
end
post '/user/account' do
  if logged_in?
    u = logged_in_user
    u.password = params["password"]
    if u.save
      flash("Account updated")
      redirect '/tasks'
    else
      tmp = []
      u.errors.each do |e|
        tmp << (e.join("<br/>"))
      end
      flash(tmp)
      redirect '/tasks'
    end
  else 
    flash("you need to log in to manage your account, existing or otherwise.")
    redirect '/'
  end
end

get '/users/list' do
  @u = User.all
  haml :'users/index'
end





# TASKS

get '/task/create' do
  haml :'tasks/create'
end

post '/task/create' do
  t = Task.new
  @tasked_by = logged_in_user
  @tasked = logged_in_user
  if params["tasked_email"]
    # you be taskin'
    unless User.first(:email => params["tasked_email"])
      flash("aint no user with that email address, son") 
      redirect '/task/create'
    end
    @tasked = User.first(:email => params["tasked_email"])
    
  end




  # 
  #   begin
  #     @tasked = User.first(:email => params["tasked_email"])
  #   rescue 
  #     flash("you can't task that person...")
  #     redirect '/task/create'
  #   end
  # else
  #   @tasked = logged_in_user
  # end
  
  t.body = params["body"]
  t.tasked_id = @tasked.id
  t.tasked_by_id = @tasked_by.id
  if t.save
    #foo
    redirect '/tasks'
  else
    flash("errors, byatch")
    redirect '/task/create'
  end
  haml :'tasks'
end

get '/task/update' do
  
  

end

post '/task/update' do
  # puts "status: #{json_params.to_s}"
  task = Task.get(params[:id])
  puts task.body
  task.status = params[:status] if params[:status]
  if task.save
    if request.xhr?
      mime :json, "application/json"
      content_type :json
      task.to_json
      "{foo: 'bar'}"
    else
      # foo!
    end
    
    redirect '/' unless self.request.env['HTTP_X_REQUESTED_WITH'] and self.request.env['HTTP_X_REQUESTED_WITH'].scan(/XML/) # Don't redirect Ajax request...
  else 
    flash("errors, byatch")
  end
end

get '/tasks' do
  if logged_in?
    @tasks = Task.all(:tasked_id => logged_in_user.id, :status => 0)
    @completed_tasks = Task.all(:tasked_id => logged_in_user.id, :status => 1)
    @deleted_tasks = Task.all(:tasked_id => logged_in_user.id, :status => -1)
    haml :'tasks/index'
  else
    redirect '/'
  end
end

get '/tasked' do
  if logged_in?
    @tasks = Task.all(:tasked_by_id => logged_in_user.id, :tasked_id.not => logged_in_user.id, :status.gt => -1)
    haml :'tasks/index'
  else
    redirect '/'
  end
end

get '/task/:id' do
  
end


