class User < ActiveRecord::Base
    has_secure_password
    has_many :blogposts

    # validates :name, presence: true 
    # validates :email, presence: true 
    # validates :password, presence: true 
    #password_digest gives us an encrypted password 
end
