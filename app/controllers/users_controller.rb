class UsersController < ApplicationController

  configure do
    enable :sessions
    set :session_secret, "asd123"
  end

  get "/users/:id" do
    if logged_in?
      @user = User.find(params[:id])
      erb :'/users/show'
    end
  end

  get "/signup" do
    if !logged_in?
    erb :'/users/signup'
    else
      redirect to "/blogposts"
    end
  end

  #saves user's info
  post '/signup' do
    if params[:name] == "" || params[:email] == "" || params[:password] == ""
      redirect to '/signup'
    else
      @user = User.new(params)
      #Here we can include more requirements of our users 
      @user.save 
      # && params[:password_digest].length > 4
      session[:user_id] = @user.id
      redirect to "/blogposts"
    end
  end

  get "/users/:id" do
    #use params to find params[:id]
    #any logic before rendering a page
    #can only see this page if you are logged in
    find_user(params[:id])
    erb :"blogposts/index"
end

patch "/users/:id" do
  find_user(params[:id])
  @user_params = update _whiltelist(params)
  @user.update(@user_params)
  redirect "/blogposts/index"
end

  get "/logout" do
    if logged_in?
        session.destroy
        redirect "/"
      else
        redirect '/'
      end
    end

  end

  # delete "/users/deactivate" do
  # end




