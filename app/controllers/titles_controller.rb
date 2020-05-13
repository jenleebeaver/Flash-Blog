class TitlesController < ApplicationController

    configure do
        enable :session
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
        erb :"titles/index"
    end

    #generates our new title 
    get "/titles/new" do
        erb :"titles/new"
    end

    # post "/titles" do
    # #creates our new title
    # end

    #shows individual title
    get "/titles/:id" do
        erb :"titles/show"
    end 

    # get "/titles/:id/edit" do
    # end

    # patch "/titles/:id" do
    # end

    # delete "/titles/:id/delete" do
    # end

 
end