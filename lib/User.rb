class User < ActiveRecord::Base
#This is the user file 
    has_many :reviews 
    has_many :hotels, through: :review 

    def self.find_by_name(name)
        User.find_by(name: name)
    end 

    def self.create_user(user_name, age, email)
        User.create(name: user_name, age: age, email: email)
    end 

    def self.find_all
        User.all #refers to the users table in database
    end


end 