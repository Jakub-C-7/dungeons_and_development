Equipment.destroy_all

Pathway.destroy_all

10.times do 
    @pathway = Pathway.create(name: Faker::Educator.unique.subject, description: Faker::Lorem.sentence(word_count: (rand(10..50))))
    @equipment = Equipment.create(
        name: Faker::Games::Minecraft.unique.item, 
        description: Faker::Lorem.sentence(word_count: (rand(10..50))), 
        pathway_id: @pathway.id,
        icon: Faker::Avatar.image(size: "50x50"),
        category: rand(0..4)
    )


    sections  = Section.order("RANDOM()").first(rand(1..6))

    sections.each do |section|
        PathwaySection.create({pathway_id: @pathway.id, section_id: section.id})
    end

    interests  = Interest.order("RANDOM()").first(rand(1..5))

    interests.each do |interest|
        PathwayInterest.create({pathway_id: @pathway.id, interest_id: interest.id})
    end
end

p "Finished section seed"