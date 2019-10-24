
require "tty-prompt"

class CommandLineInterface

    @@menu = []

    def initialize
        @@menu = []
    end 

    def self.menu
        @@menu
    end 

    def greet
        font = TTY::Font.new(:starwars)
        puts font.write("Tetravago")
        puts 'Welcome to Tetravago, the best resource for hotel information in the world!'
    end

    def mainmenu
        greet
        prompt = TTY::Prompt.new
        mainchoice = prompt.select("Here are some options for you. Use the up and down arrows to select the desired option.", cycle: true, per_page: 15) do |menu|
            menu.choice "Login", 0
            menu.choice "Sign up", 1
            menu.choice "Continue anonymous", 2
            menu.choice "Exit app", 3
        end 

        if mainchoice == 0
            empty_lines
            loginmenu
            @@menu.clear
            @@menu.push(loginoptionmenu)
        elsif mainchoice == 1
            empty_lines
            signupmenu
        elsif mainchoice == 2
            empty_lines
            nologmenu
            @@menu.clear
            @@menu << nologmenu
        elsif mainchoice == 3
            puts "Allright, goodbye" #add detonate timer bla bla bla TETRAVAGO, please come back later!
            exit 
        end 
    end 
    
    def loginmenu
        puts "Please enter your name, or enter 'exit' to go back"
        user_name = gets.chomp
        @@logged_user = User.find_by_name(user_name)
        if user_name == "exit"
            mainmenu
        elsif !@@logged_user
            puts "Sorry user does not exist, make sure you entered the username correctly."
            loginmenu
        else
            puts "Welcome #{@@logged_user.name}."
            loginoptionmenu
        end
    end 

    def loginoptionmenu
        prompt = TTY::Prompt.new
        loginchoice = prompt.select("Here are some options for you. Use the up and down arrows to select the desired option.", cycle: true, per_page: 15) do |menu|
            menu.choice "Find a hotel's review", 0
            menu.choice "Find a user's review", 1
            menu.choice "Display a user's information", 2
            menu.choice "Display a hotel's information", 3
            menu.choice "Find a hotel's average rating", 4
            menu.choice "Find the best rated hotel!", 11
            menu.choice "Add a new hotel", 5
            menu.choice "Modify one of my reviews", 6
            menu.choice "Delete one of my reviews", 7
            menu.choice "Create a new review", 8
            menu.choice "Go back to the main menu", 9
            menu.choice "Exit app", 10
        end 

        if loginchoice == 0
            empty_lines
            read_hotel_all_review
        elsif loginchoice == 1
            empty_lines
            read_user_all_review
        elsif loginchoice == 2
            empty_lines
            display_user_info
        elsif loginchoice == 3
            empty_lines
            display_hotel_info
        elsif loginchoice == 4
            empty_lines
            hotel_average_rating
        elsif loginchoice == 5
            empty_lines
            create_hotel
        elsif loginchoice == 6
            empty_lines
            modify_review
        elsif loginchoice == 7 
            empty_lines
            delete_review
        elsif loginchoice == 8
            empty_lines
            create_review
        elsif loginchoice == 9
            empty_lines
            mainmenu
        elsif loginchoice == 10
            puts "Allright, goodbye."
            exit
        elsif loginchoice == 11
            empty_lines
            most_popular_hotel
        end 
    end 

    def nologmenu
        puts "Welcome to the no log menu"
        prompt = TTY::Prompt.new
        nologinchoice = prompt.select("Here are some options for you. Use the up and down arrows to select the desired option.", cycle: true, per_page: 15) do |menu|
            menu.choice "Find a hotel's review", 0
            menu.choice "Find a user's review", 1
            menu.choice "Display a user's information", 2
            menu.choice "Display a hotel's information", 3
            menu.choice "Find a hotel's average rating", 4
            menu.choice "Find the best rated hotel!", 11
            menu.choice "Go back to the main menu", 9
            menu.choice "Exit app", 10
        end

        if nologinchoice == 0
            empty_lines
            read_hotel_all_review
        elsif nologinchoice == 1
            empty_lines
            read_user_all_review
        elsif nologinchoice == 2
            empty_lines
            display_user_info
        elsif nologinchoice == 3
            empty_lines
            display_hotel_info
        elsif nologinchoice == 4
            empty_lines
            hotel_average_rating
        elsif nologinchoice == 9
            empty_lines
            mainmenu
        elsif nologinchoice == 10
            puts "Allright, goodbye."
        elsif nologinchoice == 11
            empty_lines
            most_popular_hotel
        end 
    end 

    def signupmenu
        puts "You will now create a new account"
        create_user
    end 

    def read_hotel_all_review 
        puts "Thinking of staying somewhere but not sure if it's good? We can help you with that decision!"
        puts "Enter a hotel name to get started:"
        hotel_name = gets.chomp
        puts "You are now looking at reviews for #{hotel_name} hotel"
        hotel = Hotel.find_by_name(hotel_name) #This only search a hotel but doesn't do anything with it yet
        reviews = hotel.reviews #find if a review exists in review for a given hotel, this is the Active Record Shortcut 
        show_reviews(reviews) #shows the reviews that have been found.
        end_of_method
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
        end_of_method
    end 

    def display_user_info 
        puts "In order to get the info of a user, enter their username: "
        user_name = gets.chomp
        user = User.find_by_name(user_name)
        puts "Name: #{user.name} Age: #{user.age} Email: #{user.email}"
        end_of_method
    end 

    def display_hotel_info 
        puts "In order to get the info of a hotel, enter the hotel name: "
        hotel_name = gets.chomp
        hotel = Hotel.find_by_name(hotel_name)
        puts "Name: #{hotel.name} Email: #{hotel.email} Location: #{hotel.location} Phone Number: #{hotel.phone_number}"
        end_of_method
    end 

    def create_user 
        puts "Enter new user name"
        user_name = gets.chomp 
        puts ""
        puts "Enter your age"
        age = gets.chomp
        age = age.to_i 
        puts ""
        puts "Enter your email"
        email = gets.chomp 
        new_user = User.create_user(user_name, age, email)
        puts "Successfully added a new user !"
        loginoptionmenu
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
        end_of_method
    end 

    def create_review
        puts "Allright #{@@logged_user.name}, let's create that review!"
        @@logged_user
        puts "Now please enter the name of the hotel you stayed at"
        hotel_name = gets.chomp
        hotel = Hotel.find_by_name(hotel_name)
        if hotel == nil 
            puts "Sorry, username or hotel input is invalid. Please make sure they exist."
            end_of_method
        else 
            puts "Enter a title for your review"
            title = gets.chomp 
            puts "Enter the content of your review"
            content = gets.chomp
            puts "Please enter the rating, between 1 and 5"
            rating = gets.chomp
            new_review = Review.create_review(@@logged_user.id, hotel.id, title, content, rating)
            puts "Review successfully created!"
            end_of_method 
        end 
    end 

    def modify_review
        puts "Enter the title of the review you wish to modify or type 'exit' to go back:"
        input = gets.chomp
        review = Review.find_by_title(input)
        if review !=nil #check if review instance exists
            if review.user.id == @@logged_user.id #check if the user who wrote it and the logged in user are the same.
                puts "Enter the new content for review ##{review.id} \n\n"
                new_content = gets.chomp
                review.update_content(new_content)
                puts "Review succesfully updated!"
                end_of_method 
            else
                puts "Sorry, you can't modifiy a review that is not yours!"
                end_of_method
            end 
        elsif input == "exit"
            loginoptionmenu
        else 
            puts "Sorry, you do not have any reviews with that title! Try again."
            modify_review
        end 
    end 

    def delete_review 
        puts "Enter the title of the review you wish to delete or type 'exit' to go back:"
        input = gets.chomp
        review = Review.find_by_title(input)
        if review !=nil #check if review instance exists
            if review.user.id == @@logged_user.id
                review.delete_review
                puts "Successfully deleted the review"
                end_of_method
            else 
                puts "Sorry, you can't delete a review that is not yours!"
                end_of_method
            end
        elsif input == "exit"
            loginoptionmenu
        else 
            puts "Sorry, you do not have any reviews with that title! Try again."
            delete_review
        end
    end 

    def hotel_average_rating
       puts "In order to get the average rating of a hotel, enter the hotel name: "
       hotel_name = gets.chomp
       hotel = Hotel.find_by_name(hotel_name) #Becomes the instance that can then be called on with self in the Hotel model.
       avg_ratings = hotel.average_rating
       puts avg_ratings 
       end_of_method
    end 

    def most_popular_hotel
        all_hotels = Hotel.find_all #finds all hotel instances
        all_h_avg = {} 
        all_hotels.each do |h| 
            all_h_avg[ "#{h.name}" ] = h.average_rating
        end 
        #binding.pry
        puts all_h_avg.sort_by{|hotel, avg_r| avg_r}.last
        end_of_method
    end 

    def empty_lines 
        puts ""
        puts ""
        puts ""
        puts ""
        puts ""
    end 

    def end_of_method
      empty_lines
      @@menu
    end 

end 