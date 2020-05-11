#split users and sessions into two different controllers to hold session hashes
class SessionsController < ApplicationController
register Sinatra::ActiveRecordExtension
    set :views, Proc.new { File.join(root, "../views/") }
  
    configure do
      enable :sessions
      set :session_secret, "secret"
    end
  
  
    get '/login' do
      # the line of code below render the view page in app/views/sessions/login.erb
      erb :'users/login'
    end
  
    post '/login' do
      @user = User.find_by(email: params[:email])
      if @user && @user.authenticate(params[:password_digest])
        print @user.id
        print session
        session[:user_id] = @user.id
        redirect '/blogposts'
      else
        erb :"users/login"
      end
    end
  
    get '/sessions/logout' do
      session.clear #clears the data upon logout
      redirect '/'
    end
end
  