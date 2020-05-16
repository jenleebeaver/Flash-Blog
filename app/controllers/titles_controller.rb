class TitlesController < ApplicationController

    configure do
        enable :sessions
        set :session_secret, "asd123"
      end

    #TO DO:
    #shows index of titles X
    #show individual title
    #create a new title
    #edit individual title
    #delete individual title
    #save title?
  
    #shows index of titles 
    get "/titles" do
        if logged_in?
            @titles = Title.all
            erb :"titles/index"
        else
            erb :"users/login"
        end
    end

    # creates our new title
    post "/titles" do
        if logged_in?
            if params[:content] == ""
                redirect to "/titles/new"
            else
                @title =  current_user.titles.build(content: params[:content]) 
                #@user = current_user    
                if @title.save
                    redirect "/titles/#{@title.id}" #this redirects us to blogpost/:id
                else 
                    redirect to "/titles/new"
                end
            end
        else
            redirect to '/login'
        end
    end

    #finds specific title related to user with id # 
    get "/titles/:id" do
        if logged_in?
            @title = Title.find_by_id(params[:id])
        #use params to find params[:id]
        #any logic before rendering a page
        #can only see this page if you are logged in
        # find_blogpost(params[:id])
            erb :"titles/show"
        else
            redirect to '/login'
        end
    end

    #allows user to create a new title 
    get "/titles/new" do
        if logged_in?    
        #folder/file  
        erb :"titles/new" 
        else 
            redirect to '/login'
        end     
    end

    get "/titles/:id/edit" do
        if logged_in?
            @title = Title.find_by_id(params[:id])
            if @title && @title.user == current_user
                erb :"titles/edit"
            else 
                redirect to '/titles'
            end
        else
            redirect to '/login'
        end
    end

    patch "/titles/:id" do
        if logged_in?
            if params[:content] == ""
                redirect to "/titles/#{params[:id]}/edit"
            else
                @title = Title.find_by_id(params[:id])
                if @title && @title.user == current_user
                    if @title.update(content: params[:content])
                        redirect to "/titles/#{@title.id}"
                    else
                        redirect to "/titles/#{@title.id}/edit"
                    end
                else
                    redirect to '/titles'
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

    delete "/titles/:id/delete" do
        if logged_in?
            @title = Title.find_by_id(params[:id])
            if @title && @title.user == current_user
              @title.delete
            end
            redirect to '/titles'
          else
            redirect to '/login'
          end
        end
      end

 
