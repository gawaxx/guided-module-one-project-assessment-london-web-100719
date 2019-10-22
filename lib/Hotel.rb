class Hotel < ActiveRecord::Base
#This is the hotel class 
    has_many :reviews 
    has_many :users, through: :review 

    def self.find_by_name(name)
        Hotel.find_by(name: name)
    end 

    def self.create_hotel(hotel_name, email, location, phone_number)
        Hotel.create(name: hotel_name, email: email, location: location, phone_number: phone_number)
    end 

    def reviews
        Review.select {|r| r.hotel == self}
    end

    def average_rating
        # summ of all reviews ratings that belong to an hotel divided by total amout of reviews
        sum = 0
        self.reviews.each {|r| sum += r.rating}
        review_size = self.reviews.size
        if review_size > 0
            sum / review_size
        else 
            "Sorry no reviews exists for this hotel, create one if you wish!"
        end 
    end

end 