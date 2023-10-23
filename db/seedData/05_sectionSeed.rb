PathwaySection.destroy_all
Section.destroy_all

50.times do 
    @section = Section.create(name: Faker::Educator.unique.course_name, description: Faker::Lorem.sentence(word_count: (rand(10..50))))
    tasks  = Task.order("RANDOM()").first(rand(1..5))

    tasks.each do |task|
        SectionTask.create({section_id: @section.id, task_id: task.id})
    end

    interests  = Interest.order("RANDOM()").first(rand(1..5))

    interests.each do |interest|
        SectionInterest.create({section_id: @section.id, interest_id: interest.id})
    end
end

p "Finished pathway seed"