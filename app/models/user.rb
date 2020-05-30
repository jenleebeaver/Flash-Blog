class User < ActiveRecord::Base
    has_secure_password
    has_many :blogposts

    #def authenticate (string)
    #end

    #def blogposts 
        #SQL = "SELECT * FROM blogposts WHERE user_id = ?"
    #end


    #macros are methods that write methods for us 
    #attr_accessor :name, :age

    # validates :name, presence: true 
    # validates :email, presence: true 
    # validates :password, presence: true 
    #password_digest gives us an encrypted password 
end
