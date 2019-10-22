10.times do 
    User.create(name: Faker::Name.name, age: Faker::Number.number(digits: 2), email: Faker::Internet.unique.email)
end 

10.times do 
    Hotel.create(name: Faker::Company.unique.name, email: Faker::Internet.unique.email, location: Faker::Address.unique.street_address , phone_number: Faker::PhoneNumber.cell_phone)
end 

10.times do 
    Review.create(user_id: User.all.sample.id, hotel_id: Hotel.all.sample.id, title: Faker::Hacker.say_something_smart, content: Faker::Hacker.say_something_smart, rating: Faker::Number.between(from: 0, to: 5))
end 