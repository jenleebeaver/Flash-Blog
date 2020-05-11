class UsersController < ApplicationController

  get "/users/:id" do
    if logged_in
    @user = User.find(params[:id])
    erb :'/users/show'
    end
  end

  get "/signup" do
    erb :'/users/signup'
  end

  #saves user's info
  post "/signup" do
    @user = User.new(params)
    #Here we can include more requirements of our users 
    if @user.save 
      # && params[:password_digest].length > 4
      # session[:user_id] = @user.id
      redirect "/blogposts"
    else
      erb :'users/signup'
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
      if session.clear
        redirect "/"
      else
        redirect '/blogposts/index'
      end
    end
  end

  # delete "/users/deactivate" do
  # end

end

