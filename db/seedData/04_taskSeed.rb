SectionTask.delete_all
TaskInterest.delete_all
Task.destroy_all


50.times do 
    @task =Task.create(name: Faker::Games::Minecraft.unique.achievement, description: Faker::Lorem.sentence(word_count: (rand(10..50))))

    interests  = Interest.order("RANDOM()").first(rand(1..5))

    interests.each do |interest|
        TaskInterest.create({task_id: @task.id, interest_id: interest.id})
    end

end

p "Finished task seed"