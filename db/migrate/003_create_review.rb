class CreateReview < ActiveRecord::Migration[6.0]
#This is the database for my reviews 3
def change
    #create_table :user do |t|
      #t.string :name
      #t.string :email
      #t.string :age 
      #t.timestamps
    #end
 
    #create_table :hotel do |t|
     # t.string :name
     # t.string :email
     # t.string :location
     # t.timestamps
    #end
 
    create_table :review do |t|
      t.belongs_to :user
      t.belongs_to :hotel
      t.string :user_id
      t.string :hotel_id 
      t.string :title 
      t.string :rating
      t.timestamps
    end
end