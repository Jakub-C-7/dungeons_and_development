# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
UserInterest.destroy_all

User.destroy_all

user1 = User.create! :email => 'john@gmail.com', :password => 'topsecret', :password_confirmation => 'topsecret'
user2 = User.create! :email => 'sally@gmail.com', :password => 'topsecret', :password_confirmation => 'topsecret'
user3 = User.create! :email => 'jane@gmail.com', :password => 'topsecret', :password_confirmation => 'topsecret'

Interest.destroy_all

Interest.create([{
    name: "Software Engineer",
    isRole: true
},
{
    name: "Data Engineer",
    isRole: true
},{
    name: "Leadership",
    isRole: false
}])
interest = Interest.first
interestLast = Interest.last

user1.user_interests.create(
interest: interest
)
user1.user_interests.create(
interest: interest
)
user1.user_interests.create(
interest: interestLast
)

user2.user_interests.create(
interest: interest
)