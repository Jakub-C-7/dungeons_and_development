class TavernController < ApplicationController
  def home
  end

   #IN SERIOUS NEED OF REWORKING#


  # def retrieve_quest_interests(sectionQuests, pathwayQuests)
  #   pathwayQuests.each do |q|
  #     q['interests'] = Interest.joins(:pathway_interests).where(pathway_interests: { pathway_id: q['id']}).pluck(:name)
  #   end
  #   sectionQuests.each do |q|
  #     q['interests'] = Interest.joins(:section_interests).where(section_interests: { section_id: q['id']}).pluck(:name)
  #   end
  #   @quests = pathwayQuests + sectionQuests
  # end

  def retrieve_quest_interests_and_sections(pathwayQuests)
      pathwayQuests.each do |q|
        pathway = Pathway.find(q['id'])
        q['interests'] = pathway.interests.pluck(:name)
        q['sections'] = pathway.sections.pluck(:name)
        q['status'] = current_user.pathways.joins(:user_pathways).where(user_pathways: { pathway_id: q['id']} ).pluck("user_pathways.progress")[0]
        reward = Equipment.where(pathway_id: q['id']).first
        q['reward_icon'] = reward.icon
        q['reward_name'] = reward.name
        # q['interests'] = Interest.joins(:pathway_interests).where(pathway_interests: { pathway_id: q['id']}).pluck(:name)
        # q['sections'] = Section.joins(:pathway_sections).where(pathway_sections: { pathway_id: q['id']}).pluck(:name)
      end
      
      return pathwayQuests
    end

  def quest_board
    @selected_interests = current_user.interests.pluck(:id)
    @interests = Interest.all
    @recommendedQuests = Pathway.order("RANDOM()").first(3)

    pathwayQuests = Pathway.joins(:pathway_interests).where(pathway_interests: { interest_id: @selected_interests }).order(:name).as_json
    # sectionQuests = Section.joins(:section_interests).where(section_interests: { interest_id: @selected_interests }).order(:name).as_json 
    # retrieve_quest_interests(sectionQuests, pathwayQuests)
    @quests = retrieve_quest_interests_and_sections(pathwayQuests)

  end

  def resume_quest
    pathway = Pathway.find(params[:quest_id])
    UserPathway.where(pathway_id: pathway.id).where(user_id: current_user.id).update_all(progress: 1)
    respond_to do |format|      
      format.html { render :quest_board }
      format.turbo_stream do 
        render turbo_stream:
          turbo_stream.update('quest-status-' + params[:quest_id] + params[:location],
                              partial: 'tavern/quest_status',
                              locals: { questid: params[:quest_id], status: "started", location:params[:location] })
      end
    end
  
 end
  def pause_quest
     pathway = Pathway.find(params[:quest_id])
     UserPathway.where(pathway_id: pathway.id).where(user_id: current_user.id).update_all(progress: 0)
     respond_to do |format|      
      format.html { render :quest_board }
      format.turbo_stream do 
        render turbo_stream:
          turbo_stream.update('quest-status-' + params[:quest_id]+ params[:location],
                              partial: 'tavern/quest_status',
                              locals: { questid: params[:quest_id], status: "notStarted",location:params[:location]  })
      end
    end
    #  sections = pathway.sections
    #  sections.each do |section|
    #   userSection = current_user.join(user_sections).where(section_id: section.id).first
    #   if(userSection.progress != 2)
    #     userSection.update(progress: 0)
    #     tasks = userSection.tasks
    #     tasks.each do |task|
    #       userTask = current_user.join(user_tasks).where(task_id: task.id).first 
    #       if(userTask.progress != 2)
    #         userTask.update(progress: 0)
    #       end

    #   end
  end

  def add_quest
    pathway = Pathway.find(params[:quest_id])
    UserPathway.create(
        user_id: current_user.id,
        pathway_id: pathway.id,
        progress: 1
    )

    selected_sections  = pathway.sections;
    selected_sections.each do |section|
      if !UserSection.exists?(user_id: current_user.id, section_id: section.id)
          UserSection.create(
            user_id: current_user.id,
            section_id: section.id,
            progress: 1
        )
   
        selected_tasks = section.tasks;
        selected_tasks.each do |task|
            if !UserTask.exists?(user_id: current_user.id, task_id: task.id)
              UserTask.create(
                user_id: current_user.id,
                task_id: task.id,
                progress: 1
              )
            end
          
        end
      end
    end
    respond_to do |format|      
      format.html { render :quest_board }
      format.turbo_stream do 
        render turbo_stream:
          turbo_stream.update('quest-status-' + params[:quest_id] + params[:location],
                              partial: 'tavern/quest_status',
                              locals: { questid: params[:quest_id], status: "started",location:params[:location]  })
      end
    end
  end

  def update_recommended
      p params[:selected_quest]
      quest  = Pathway.find(params[:selected_quest]).as_json
      pathway = Pathway.find(params[:selected_quest])
      quest = pathway.as_json
       
      quest['interests'] = pathway.interests.pluck(:name)
      quest['sections'] = pathway.sections.pluck(:name)
      quest['status'] = current_user.pathways.joins(:user_pathways).where(user_pathways: { pathway_id: quest['id']} ).pluck("user_pathways.progress")[0]
      reward = Equipment.where(pathway_id: quest['id']).first
      quest['reward_icon'] = reward.icon
      quest['reward_name'] = reward.name


      respond_to do |format|      
        format.html { render :quest_board }
        format.turbo_stream do 
          render turbo_stream:
            turbo_stream.update('recommended-quest-display',
                                partial: 'tavern/quest',
                                locals: { quest: quest, location:"recommended" })
        end
      end
  end



  def search_quests
    search_field = params[:search].present? ? params[:search] : ""
    if params[:interests].present? then 
      quests = Pathway.where("name ILIKE ?", "%" + search_field + "%").joins(:pathway_interests).where(pathway_interests: { interest_id: params[:interests] }).order(:name).as_json
      @quests = retrieve_quest_interests_and_sections(quests)
    else
      quests = Pathway.where("name ILIKE ?", "%" + search_field + "%").order(:name).as_json
      @quests = retrieve_quest_interests_and_sections(quests)
    end
    
#
    # if params[:interests].present? then
    #   if params[:category] == "1" then
    #     quests = Pathway.where("name ILIKE ?", "%" + search_field + "%").joins(:pathway_interests).where(pathway_interests: { interest_id: params[:interests] }).order(:name).as_json
    #     retrieve_quest_interests([], quests)
    #   elsif params[:category] == "2" then
    #     quests = Section.where("name ILIKE ?", "%" + search_field + "%").joins(:section_interests).where(section_interests: { interest_id: params[:interests] }).order(:name).as_json
    #     retrieve_quest_interests(quests, [])
    #   else
    #     sectionQuests = Section.where("name ILIKE ?", "%" + search_field + "%").joins(:section_interests).where(section_interests: { interest_id: params[:interests] }).order(:name).as_json
    #     pathwayQuests = Pathway.where("name ILIKE ?", "%" + search_field + "%").joins(:pathway_interests).where(pathway_interests: { interest_id: params[:interests] }).order(:name).as_json
    #     retrieve_quest_interests(sectionQuests, pathwayQuests)
    #   end
    # else
    #   if params[:category] == "1" then
    #     quests = Pathway.where("name ILIKE ?", "%" + search_field + "%").order(:name).as_json
    #     retrieve_quest_interests([], quests)
    #   elsif params[:category] == "2" then
    #     quests = Section.where("name ILIKE ?", "%" + search_field + "%").order(:name).as_json        
    #     retrieve_quest_interests(quests, [])
    #   else
    #     sectionQuests = Section.where("name ILIKE ?", "%" + search_field + "%").order(:name).as_json 
    #     pathwayQuests = Pathway.where("name ILIKE ?", "%" + search_field + "%").order(:name).as_json 
    #     retrieve_quest_interests(sectionQuests, pathwayQuests)
    #   end
    # end
    respond_to do |format|
      format.html { render :quest_board }
      format.turbo_stream do 
        render turbo_stream:
          turbo_stream.update('quests',
                              partial: 'tavern/quests',
                              locals: { quests: quests })
          
      end
    end

  end
end
