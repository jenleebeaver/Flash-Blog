#split users and sessions into two different controllers to hold session hashes
class SessionsController < ApplicationController
register Sinatra::ActiveRecordExtension
    set :views, Proc.new { File.join(root, "../views/") }
  
    configure do
      enable :sessions
      set :session_secret, "secret"
    end
  
  
    get '/login' do
      if !logged_in?
        erb :'users/login'
      else
        redirect to '/blogposts'
      end
    end


    post '/login' do
      @user = User.find_by(email: params[:email])
      if @user && @user.authenticate(params[:password_digest])
        session[:user_id] = @user.id
        redirect to '/blogposts'
      else
       redirect to"users/login"
      end
    end
  
    get '/sessions/logout' do
      session.clear #clears the data upon logout
      redirect '/'
    end
    
end
  