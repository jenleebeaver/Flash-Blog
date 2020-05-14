require './config/environment'

# HTTP verbs -> GET stuff form server/db/html (requests info and displays to page) 
# -> POST send info/data to server/db (init obj, save, send)

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "asd123"
  end

  get "/" do
    erb :welcome
  end

  post "/" do
    @blogpost = Blogposts.new
    @title = Titles.new
    @user = Users.new
  end

  #this is for all controllers to have access to 
  helpers do

    def logged_in?
      !!session[:user_id]
    end

    def current_user
      #checks to see if @user is false
      @user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end

    #duplicate code
    # def current_user
    #   @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    # end

  end

end

#create a post for each db when it is specific to one person 
