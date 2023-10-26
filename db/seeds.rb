# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'faker'

require_relative './seedData/01_usersSeed.rb'
require_relative './seedData/02_interestSeed.rb'
require_relative './seedData/03_characterSelectionSeed.rb'
require_relative './seedData/04_taskSeed.rb'
require_relative './seedData/05_sectionSeed.rb'
require_relative './seedData/06_pathwaySeed.rb'



# User.destroy_all

# user1 = User.create! :email => 'john@gmail.com', :password => 'topsecret', :password_confirmation => 'topsecret'
# user2 = User.create! :email => 'sally@gmail.com', :password => 'topsecret', :password_confirmation => 'topsecret'
# user3 = User.create! :email => 'jane@gmail.com', :password => 'topsecret', :password_confirmation => 'topsecret'

# Pathway.destroy_all

# Pathway.create([{
#     name: "AWS Cloud Practitioner",
#     description: "The AWS Certified Cloud Practitioner validates foundational, high-level understanding of AWS Cloud, services, and terminology.  This is a good starting point on the AWS Certification journey for individuals with no prior IT or cloud experience switching to a cloud career or for line-of-business employees looking for foundational cloud literacy."
# },
# {
#     name: "Azure Fundamentals",
#     description: "Whether you’re new to the field or a seasoned professional, mastering the basics in Microsoft Azure can help you jump-start your career and prepare you to dive deeper into the many technical opportunities Azure offers."
# }])
# pathway = Pathway.first
# pathwayLast = Pathway.last

# Section.destroy_all

# Section.create([{
#     name: "Describe cloud concepts",
#     description: "First section of the AZ-900 exam."
# },
# {
#     name: "Describe cloud concepts",
#     description: "First section of the AWS Cloud practitioner exam"
# }])
# section = Section.first
# sectionLast = Section.last

# Task.destroy_all

# Task.create([{
#     name: "Scaling",
#     description: "Describe the difference between Horizontal and Vertical Scaling"
# },
# {
#     name: "Virtualisation",
#     description: "Describe the concept of virtualisation in relation to the cloud"
# }])
# task = Task.first
# taskLast = Task.last

# PathwayInterest.destroy_all

# PathwayInterest.create([{
#     pathway_id: 1,
#     interest_id: 1
# },
# {
#     pathway_id: 2,
#     interest_id: 1
# }])


# SectionInterest.destroy_all

# SectionInterest.create([{
#     section_id: 1,
#     interest_id: 1
# },
# {
#     section_id: 2,
#     interest_id: 1
# }])


# TaskInterest.destroy_all

# TaskInterest.create([{
#     task_id: 1,
#     interest_id: 1
# },
# {
#     task_id: 2,
#     interest_id: 1
# }])

# PathwaySection.destroy_all

# PathwaySection.create([{
#     pathway_id: 1,
#     section_id: 1
# },
# {
#     pathway_id: 2,
#     section_id: 2
# }])

# SectionTask.destroy_all

# SectionTask.create([{
#     section_id: 1,
#     task_id: 1
# },
# {
#     section_id: 2,
#     task_id: 2
# }])

# UserTask.destroy_all

# user1.user_tasks.create(
#     task_id: 1,
#     progress: 0
#     )


UserPathway.destroy_all

user1.user_pathways.create(
    pathway_id: 1,
    progress: 0
    )

user1.user_pathways.create(
    pathway_id: 2,
    progress: 2
    )

UserSection.destroy_all

user1.user_sections.create(
    section_id: 1,
    progress: 0
    )
    
user1.user_sections.create(
    section_id: 2,
    progress: 2
    )
    