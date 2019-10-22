
class CommandLineInterface
    def greet
        puts 'Welcome to Tetravago, the best resource for hotel information in the world!'
        puts "here are some options for you, type the number corresponding to the option to call it."
        puts "If you wish to exit, type 'exit' or 0"
        puts "(1) Find a hotel's reviews"
        puts "(2) Find a user's reviews"
        puts "(3) Display information of a user"
        puts "(4) Display information of a hotel"
        puts "(5) Add a new user"
        puts "(6) Add a new hotel"
        puts "(7) Modify a review you wrote"
        puts "(8) Delete a review you wrote"
        puts "(9) Create a review"
        puts "(10) Find a hotel's average rating"
        puts "What do you wish to do?"
    end

    def start 
        greet 
        choice = gets.chomp
        if choice == "1"
            empty_lines
            read_hotel_all_review
        elsif choice == "2"
            empty_lines
            read_user_all_review
        elsif choice == "3"
            empty_lines
            display_user_info
        elsif choice == "4"
            empty_lines
            display_hotel_info
        elsif choice == "5"
            empty_lines
            create_user
        elsif choice == "6"
            empty_lines
            create_hotel
        elsif choice == "7"
            empty_lines
            modify_review
        elsif choice == "8"
            empty_lines
            delete_review 
        elsif choice == "9"
            empty_lines
            create_review
        elsif choice == "10"
            empty_lines
            hotel_average_rating
        elsif choice == "exit" ||  choice == "0"
            puts "k bye"
        else 
            puts "You didn't want to comply and neither did I, now I am leaving."
        end 
    end 

    def read_hotel_all_review 
        puts "Thinking of staying somewhere but not sure if it's good? We can help you with that decision!"
        puts "Enter a hotel name to get started:"
        hotel_name = gets.chomp
        puts "You are now looking at reviews for #{hotel_name} hotel"
        hotel = Hotel.find_by_name(hotel_name) #This only search a hotel but doesn't do anything with it yet
        reviews = hotel.reviews #find if a review exists in review for a given hotel, this is the Active Record Shortcut 
        show_reviews(reviews) #shows the reviews that have been found.
        empty_lines
        start
    end 

    def show_reviews(reviews)
        reviews.each do |review|
            puts ""
            puts "Username: #{review.user.name}"
            puts "Review Content: #{review.content}"
            puts "Rating: #{review.rating}"
            puts ""
        end
    end

    def read_user_all_review
        puts "Curious about the review's someone wrote?"
        puts "Write their full name here:"
        user_name = gets.chomp 
        user = User.find_by_name(user_name)
        reviews = user.reviews #find if a review exists in review for a given user, this is the Active Record Shortcut 
        show_reviews(reviews) #shows the reviews that have been found.
        empty_lines
        start 
    end 

    def display_user_info 
        puts "In order to get the info of a user, enter their username: "
        user_name = gets.chomp
        user = User.find_by_name(user_name)
        puts "Name: #{user.name} Age: #{user.age} Email: #{user.email}"
        empty_lines
        start
    end 

    def display_hotel_info 
        puts "In order to get the info of a hotel, enter the hotel name: "
        hotel_name = gets.chomp
        hotel = Hotel.find_by_name(hotel_name)
        puts "Name: #{hotel.name} Email: #{hotel.email} Location #{hotel.location} Phone Number #{hotel.phone_number}"
        empty_lines
        start
    end 

    def create_user 
        puts "Enter new user name"
        user_name = gets.chomp 
        puts ""
        puts "Enter your age"
        age = gets.chomp 
        puts ""
        puts "Enter your email"
        email = gets.chomp 
        new_user = User.create_user(user_name, age, email)
        puts "Successfully added a new user !"
        empty_lines
        start
    end 

    def create_hotel 
        puts "Enter new hotel's name"
        hotel_name = gets.chomp 
        puts ""
        puts "Enter the hotel's email"
        puts ""
        email = gets.chomp
        puts "Enter the hotel's address"
        location = gets.chomp 
        puts ""
        puts "Enter the hotel's phone number"
        phone_number = gets.chomp
        new_hotel = Hotel.create_hotel(hotel_name, email, location, phone_number)
        puts "Successfully added a new hotel !"
        empty_lines
        start
    end 

    def create_review
        puts "Allright, first please enter your user name:"
        user_name = gets.chomp
        user = User.find_by_name(user_name)
        puts "Now please eneter the name of the hotel you stayed at"
        hotel_name = gets.chomp
        hotel = Hotel.find_by_name(hotel_name)
        if user == nil || hotel == nil 
            puts "Sorry, username or hotel input is invalid. Please make sure they exist."
            empty_lines
            start
        else 
            puts "Enter a title for your review"
            title = gets.chomp 
            puts "Enter the content of your review"
            content = gets.chomp
            puts "Please enter the rating, between 1 and 5"
            rating = gets.chomp
            new_review = Review.create_review(user.id, hotel.id, title, content, rating)
            puts "Review successfully created!"
            empty_lines
            start 
        end 
    end 

    def empty_lines 
        puts ""
        puts ""
        puts ""
        puts ""
        puts ""
    end 

    def modify_review
        puts "Enter the title of the review you wish to modify:"
        input = gets.chomp
        review = Review.find_by_title(input)
        puts "Enter the new content for review ##{review.id} \n\n"
        new_content = gets.chomp
        review.update_content(new_content)
        puts "Review succesfully updated!"
        empty_lines
        start
    end 

    def delete_review 
        puts "Enter the title of the review you wish to delete:"
        input = gets.chomp
        review = Review.find_by_title(input)
        review.delete_review
        puts "Successfully deleted the review"
        empty_lines
        start
    end 

   def hotel_average_rating
       puts "In order to get the average rating of a hotel, enter the hotel name: "
       hotel_name = gets.chomp
       hotel = Hotel.find_by_name(hotel_name)
       avg_ratings = hotel.average_rating
       puts avg_ratings 
       empty_lines
       start
   end 

end 