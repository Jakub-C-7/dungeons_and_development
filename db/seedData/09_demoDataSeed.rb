pathway = Pathway.create(name: "IAF Introduction", description: "Discover the Integrated Architecture Framework (IAF), Capgemini's enterprise architecture framework")
sections = ["Discovering IAF", "Practicing IAF", "Getting IAF Level 1 Certified", "Staying sharp on IAF"]

interests  = Interest.order("RANDOM()").first(rand(1..5))

interests.each do |interest|
    PathwayInterest.create({pathway_id: pathway.id, interest_id: interest.id})
end

weapon_index = NUM_OF_WEAPONS + 1
sections.each do |sectionName| 
    section = Section.create(name: sectionName, description: Faker::Lorem.sentence(word_count: (rand(10..50))))
    tasks  = Task.order("RANDOM()").first(5)
    x = 1
    tasks.each do |task|
        SectionTask.create({section_id: section.id, task_id: task.id, step_number: x})
        x += 1
    end
    PathwaySection.create({pathway_id: pathway.id, section_id: section.id})
end 
Equipment.create(
    name: Faker::Games::Minecraft.unique.item, 
    description: Faker::Lorem.sentence(word_count: (rand(10..50))), 
    pathway_id: pathway.id,
    icon: "/assets/equipment/weapon" + weapon_index.to_s + ".jpg",
    category: 1)

weapon_index = weapon_index + 1
pathways = ["Microservices Architecture Advanced | Data & AI Campus", "iTransform: Spring Cloud Microservices : Level 1", 
            "Distributed Systems: Logging and Monitoring in microservice architecture", "Understand AWS Cloud Security", "IC Agile - Agile Fundamentals"
]

pathways.each do |pathwayName|
    @pathway = Pathway.create(name: pathwayName, description: Faker::Lorem.sentence(word_count: (rand(10..50))))
    sections  = Section.order("RANDOM()").first(rand(1..6))

    sections.each do |section|
        PathwaySection.create({pathway_id: @pathway.id, section_id: section.id})
    end
    interests  = Interest.order("RANDOM()").first(rand(1..5))

    interests.each do |interest|
        PathwayInterest.create({pathway_id: @pathway.id, interest_id: interest.id})
    end

    Equipment.create(
        name: Faker::Games::Minecraft.unique.item, 
        description: Faker::Lorem.sentence(word_count: (rand(10..50))), 
        pathway_id: @pathway.id,
        icon: "/assets/equipment/weapon" + (weapon_index).to_s + ".jpg",
        category: 1)
    weapon_index = weapon_index + 1
end

pathway = Pathway.create(name: "Microservices Architecture (Beginner)", description: "In software engineering, a microservices architecture is a variant of the service-orientated architecture structural style. 
                                It is an architectural pattern that arranges an application as a collection of loosely coupled, fine-grained services, communicating through lightweight protocols.
                                This beginner pathway will grow your awareness of Microservices and help you begin to incorporate this new skill into your work")

section = Section.create(name: "Discover Microservices Architecture", description: "Explore the conten in this section to discover Microservices as a concept as well as when and how to make us it")

task = Task.create(name:"What is Microservices Architecture?", description: "Let us understand Microservices and its scope.")
SectionTask.create({section_id: section.id, task_id: task.id, step_number: 1})

task = Task.create(name:"Overview of microservices", description: "Microservices - also known as the microservice architecture - is an
architectural style that structures an application as a collection of services
that are: Independently deployable Loosely coupled Organized around
business capabilities Owned by a small team The microservice architecture
enables an organization to deliver large, complex applications rapidly,
frequently, reliably and sustainably - a necessity for competing and winning
in today’s world.")
SectionTask.create({section_id: section.id, task_id: task.id, step_number: 2})

task = Task.create(name:"Microservices Architecture Fundamentals", description: "Microservice architectures enable you to create
scalable, flexible, and resilient distributed cloud
applications. In this course, Microservices
Fundamentals, you will learn about the options
for solving different challenges that arise and
see recommended practices in action that you
can apply to your own microservices.")
SectionTask.create({section_id: section.id, task_id: task.id, step_number: 3})

PathwaySection.create({pathway_id: pathway.id, section_id: section.id, step_number: 1})

section = Section.create(name: "Build Microservices Architecutre", description: "Build upon your awareness of Microservices Architecture and explore further tips to aid you in developing your skills.")

task = Task.create(name:"Microservices Architecture: The Design Principles", description: "Sometimes however the world of
microservices can feel overwhelming in terms
of the many design approaches and
technologies that allegedly support a good
implementation of a microservices based
system. The best way to achieve clarity and
direction in terms of how to implement an
effective microservices system is to first
understand the core design principles that help
implement a good microservices based system.")
SectionTask.create({section_id: section.id, task_id: task.id, step_number: 1})


task = Task.create(name:"Master Microservices with Spring Boot and Spring Cloud", description: "Do you want to learn from the MOST POPULAR Course (180K+ Students)
on Microservices? Do you want to Learn to Build an Amazing REST API
with Spring Boot? Do you want to learn what the Hype about
Microservices is all about? Do you want to Build Microservices with
Spring Boot and Spring Cloud? Do you want to Build Containers with
Docker? Do you want to orchestrate Microservices with Kubernetes?")
SectionTask.create({section_id: section.id, task_id: task.id, step_number: 2})

task = Task.create(name:"Microservices - AWS", description: "AWS Microservices is an AWS ecosystem tailored for microservices
architecture. It enables the development, deployment, and scaling of
microservices. Amazon ECS and EKS handle container orchestration,
while AWS Lambda offers serverless compute for event-driven
microservices. Amazon API Gateway manages APIs, and AWS provides
tools for service discovery, load balancing, monitoring, and logging.")
SectionTask.create({section_id: section.id, task_id: task.id, step_number: 3})

task = Task.create(name:"Microservices - Google Cloud", description: "Google Cloud offers a comprehensive platform for implementing
microservices, an architectural approach for building modular, scalable
applications. Key components include Google Kubernetes Engine (GKE)
for container orchestration and management, enabling easy scaling and
deployment.")
SectionTask.create({section_id: section.id, task_id: task.id, step_number: 4})

task = Task.create(name:"Continue your learning journey to Practitioner level", description: "Ready to learn more about Microservices Architecture? Continue to the next level of learning to continue to advance your skill development")
SectionTask.create({section_id: section.id, task_id: task.id, step_number: 5})

PathwaySection.create({pathway_id: pathway.id, section_id: section.id, step_number: 5})


interestArray = ["Google Cloud", "AWS", "Microservices"]

interestArray.each do |interest|
    @interest = Interest.create(name: interest, isRole: false )
    PathwayInterest.create({pathway_id: @pathway.id, interest_id: @interest.id})
end

Equipment.create(
        name: "Sword of Microserving", 
        description: Faker::Lorem.sentence(word_count: (rand(10..50))), 
        pathway_id: pathway.id,
        icon: "/assets/equipment/weapon10.jpg",
        category: 1)
