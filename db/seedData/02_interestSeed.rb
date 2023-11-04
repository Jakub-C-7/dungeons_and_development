TaskInterest.delete_all
SectionInterest.delete_all
PathwayInterest.delete_all

Interest.destroy_all


jobArray = ["Architect", "Business Analyst", "Project Manager", "Software Engineer", "Platform Engineer"]
interestArray = ["Digital Architecture", "System Architecture", "Cloud Security", "Data Model Design", "Azure DevOps", "Agile Methodology", "Integrated Architecture Framework (IAF)",
                "Proposal Writing", "Java", "Object Orientated Programming (OOP)", "Testing", "Linux","CI/CD"]

jobArray.each do |job|
    Interest.create(name: job, isRole: true )
end
interestArray.each do |interest| 
    Interest.create(name: interest, isRole: false)
end
# 10.times do 
#     Interest.create(name: Faker::Job.unique.field, isRole: true )
# end

# 30.times do
#     Interest.create(name: Faker::Hobby.unique.activity, isRole: false)
# end

p "Finished Interest Seeds"