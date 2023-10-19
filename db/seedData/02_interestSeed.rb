
Interest.destroy_all

10.times do 
    Interest.create(name: Faker::Job.field, isRole: true )
end

10.times do
    Interest.create(name: Faker::Hobby.activity, isRole: false)
end

p "Finished Interest Seeds"