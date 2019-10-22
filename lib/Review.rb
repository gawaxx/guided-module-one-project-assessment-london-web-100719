class Review < ActiveRecord::Base
#This is the review file
    belongs_to :user 
    belongs_to :hotel  

    def update_content(new_content)
        self.update(content: new_content)
    end

    def self.find_by_title(title)
        Review.find_by(title: title) #calls on the table Review in the database
    end

    def delete_review
        self.delete
    end 

    def self.create_review(user_id, hotel_id, title, content)
        Review.create(user_id: user_id, hotel_id: hotel_id, title: title, content: content)
    end 

end 