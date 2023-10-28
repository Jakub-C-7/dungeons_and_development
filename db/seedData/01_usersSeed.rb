UserInterest.destroy_all
UserPathway.destroy_all
UserSection.destroy_all
UserTask.destroy_all
UserEquipment.destroy_all

User.destroy_all

user1 = User.create! :email => 'john@gmail.com', :password => 'topsecret', :password_confirmation => 'topsecret'
user2 = User.create! :email => 'sally@gmail.com', :password => 'topsecret', :password_confirmation => 'topsecret'
user3 = User.create! :email => 'jane@gmail.com', :password => 'topsecret', :password_confirmation => 'topsecret'

# Interest.destroy_all

# Interest.create([{
#     name: "Software Engineer",
#     isRole: true
# },
# {
#     name: "Data Engineer",
#     isRole: true
# },{
#     name: "Leadership",
#     isRole: false
# }])
# interest = Interest.first
# interestLast = Interest.last

# user1.user_interests.create(
# interest: interest,
# isPrimaryRole: true
# )
# user1.user_interests.create(
# interest: interest
# )
# user1.user_interests.create(
# interest: interestLast,
# isPrimaryRole: true
# )   #this one is not created because isPrimaryRole can not be true for multiple entries

# user2.user_interests.create(
# interest: interest
# )
# puts 'Hello World!'
