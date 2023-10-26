TaskInterest.delete_all
SectionInterest.delete_all
PathwayInterest.delete_all

Interest.destroy_all

10.times do 
    Interest.create(name: Faker::Job.unique.field, isRole: true )
end

30.times do
    Interest.create(name: Faker::Hobby.unique.activity, isRole: false)
end

p "Finished Interest Seeds"