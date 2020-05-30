class BlogpostsController < ApplicationController

    configure do
        enable :sessions
        set :session_secret, "asd123"
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
            # binding.pry
            # @blogposts = current_user.blogposts  
            erb :"blogposts/index"
        else
            erb :"users/login"    
        end
    end

    #allows user to create a new blogpost 
    get "/blogposts/new" do
        if logged_in?     
        #folder/file  
        erb :"blogposts/new" 
        else 
            redirect to '/login'
        end     
    end

    #SHOWS AND SAVES BLOGPOST TO ID 
     #this posts our blog from forms and saves to an instance
     post "/blogposts" do
        if logged_in?
            if params[:content] == ""
                redirect to "/blogposts/new"
            else
                @blogpost =  current_user.blogposts.build(content: params[:content]) 
                #@user = current_user    
                if @blogpost.save
                    redirect "/blogposts/#{@blogpost.id}" #this redirects us to blogpost/:id
                else 
                    redirect to "/blogposts/new"
                end
            end
        else
            redirect to '/login'
        end
    end

    get "/blogposts/newest" do 
        if logged_in?
            @blogpost = Blogpost.all.last
            erb :"blogposts/newest"
        else
            redirect to '/blogposts'
        end
    end

    #finds specific blogpost related to user with id # 
    get "/blogposts/:id" do
        if logged_in?
            @blogpost = Blogpost.find_by_id(params[:id])
        #use params to find params[:id]
        #any logic before rendering a page
        #can only see this page if you are logged in
        # find_blogpost(params[:id])
            erb :"blogposts/show"
        else
            redirect to '/login'
        end
    end

   #allows us to edit specific blogpost 
    get "/blogposts/:id/edit" do
        if logged_in?
            @blogpost = Blogpost.find_by_id(params[:id])
            if @blogpost && @blogpost.user == current_user
                erb :"blogposts/edit"
            else 
                redirect to '/blogposts'
            end
        else
            redirect to '/login'
        end
    end

    patch "/blogposts/:id" do
        if logged_in?
            if params[:content] == ""
                redirect to "/blogposts/#{params[:id]}/edit"
            else
                @blogpost = Blogpost.find_by_id(params[:id])
                if @blogpost && @blogpost.user == current_user
                    if @blogpost.update(content: params[:content])
                        redirect to "/blogposts/#{@blogpost.id}"
                    else
                        redirect to "/blogposts/#{@blogpost.id}/edit"
                    end
                else
                    redirect to '/blogposts'
                end
            end
        else
            redirect to '/login'
        # find_blogpost(params[:id])
        # @blogpost_params = update _whiltelist(params)
        # @blogpost.update(@blogpost_params)
        # redirect "/blogposts/#{@blogpost.id}"
        end
    end

    #deletes individual blogpost 
    delete "/blogposts/:id/delete" do
        if logged_in?
            @blogpost = Blogpost.find_by_id(params[:id])
            if @blogpost && @blogpost.user == current_user
              @blogpost.delete
            end
            redirect to '/blogposts'
          else
            redirect to '/login'
        end
    end
end




#write a custom method so that when a user visits localhost:9393/blogposts/newest the user sees the last blog post in the database, regardless of who wrote it
# post "/blogposts/newest" do 
#     if logged_in?
#         @blogpost = Blogpost.all.last
#         redirect to '/newest'
#     else
#         redirect to '/'
#     end
# end








    #     find_blogpost(params[:id])
    #     @blogpost.destroy
    #     if @blogpost.errors
    #         erb :"blogposts/index"
    #     else
    #         erb :"blogposts/#{@blogpost.id}"
    #     end
    # end

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

 

