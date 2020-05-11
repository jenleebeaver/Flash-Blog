class BlogpostsController < ApplicationController

    configure do
        enable :sessions
        set :session_secret, "secret"
      end

    #TO DO:
    # show index of blogposts X
    #creates a new blogpost X 
    #post/show individual blogpost X
    #edit individual blogpost -> update X
    #delete individual blogpost X
    #custom routes

    #shows index of blogposts
    # get "/blogposts/feed" do
    #     @blogposts = Blogpost.all
    #     erb :"blogposts/feed"
    # end

    get "/blogposts" do
        if logged_in?
            @blogposts = Blogpost.all
            erb :"blogposts/feed"
            # @blogposts = current_user.blogposts  
        end
    end

    #allows user to create a new blogpost 
    get "/blogposts/new" do     
        #folder/file  
        erb :"blogposts/new"      
    end

    #SHOWS AND SAVES BLOGPOST TO ID 
     #this posts our blog from forms and saves to an instance
     post "/blogposts" do
        @blogpost =  Blogpost.new(params) 
        @user = current_user    
        if @blogpost.save
            redirect "/blogposts/#{@blogpost.id}" #this redirects us to blogpost/:id
        else 
            erb :"blogposts/new"
        end
    end

    #finds specific blogpost related to user with id # 
    get "/blogposts/:id" do
        #use params to find params[:id]
        #any logic before rendering a page
        #can only see this page if you are logged in
        find_blogpost(params[:id])
        erb :"blogposts/show"
    end

   #allows us to edit specific blogpost 
    get "/blogposts/:id/edit" do
        find_blogpost(params[:id])
        erb :"blogposts/edit"
    end

    patch "/blogposts/:id" do
        find_blogpost(params[:id])
        @blogpost_params = update _whiltelist(params)
        @blogpost.update(@blogpost_params)
        redirect "/blogposts/#{@blogpost.id}"
    end

    #deletes individual blogpost 
    delete "/blogposts/:id/delete" do
        find_blogpost(params[:id])
        @blogpost.destroy
        if @blogpost.errors
            erb :"blogposts/index"
        else
            erb :"blogposts/#{@blogpost.id}"
        end
    end

    #custom routes 
    #can't call this method 
    private 

        def update_whiltelist(params)
            {
                content: params[:content]
            }
        end

        def find_blogpost(id)
            @blogpost = Blogpost.find(id)
        end

end