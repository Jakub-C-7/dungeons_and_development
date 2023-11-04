pathways  = Pathway.order("RANDOM()").first(NUM_OF_PATHWAYS)

y = 0;

NUM_OF_CHEST.times do |x|
    Equipment.create(
        name: Faker::Games::Minecraft.unique.item, 
        description: Faker::Lorem.sentence(word_count: (rand(10..50))), 
        pathway_id: pathways[y].id,
        icon: "/assets/equipment/chest" + (x + 1).to_s + ".jpg",
        category: 2)
    y = y + 1
   
end

NUM_OF_BOTTOMS.times do |x|
    Equipment.create(
        name: Faker::Games::Minecraft.unique.item, 
        description: Faker::Lorem.sentence(word_count: (rand(10..50))), 
        pathway_id: pathways[y].id,
        icon: "/assets/equipment/bottoms" + (x + 1).to_s + ".jpg",
        category: 3)
    y = y + 1
end

NUM_OF_HELMET.times do |x|
    Equipment.create(
        name: Faker::Games::Minecraft.unique.item, 
        description: Faker::Lorem.sentence(word_count: (rand(10..50))), 
        pathway_id: pathways[y].id,
        icon: "/assets/equipment/helmet" + (x + 1).to_s + ".jpg",
        category: 0)
    y = y + 1
end


NUM_OF_WEAPONS.times do |x|
    Equipment.create(
        name: Faker::Games::Minecraft.unique.item, 
        description: Faker::Lorem.sentence(word_count: (rand(10..50))), 
        pathway_id: pathways[y].id,
        icon: "/assets/equipment/weapon" + (x + 1).to_s + ".jpg",
        category: 1)
    y = y + 1
end

