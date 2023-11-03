class ActiveQuestsController < ApplicationController
  def home
    @current_pathways = current_user.user_pathways.joins(:pathway).where(progress: "started").select('pathways.*,user_pathways.*');
    # @latest_pathway = current_user.user_pathways.joins(:pathway).where(progress: "started").select('pathways.*,user_pathways.*').order(:id).pluck(:id);

  end

  #called when a user chooses a new pathway by clicking a pathway button
  def refreshPathway
    # p params
    # p params[:selected_pathway]

    @selected_pathway_id = params[:selected_pathway]
    # selected_pathway_id = '1'

    # @current_sections = Section.joins(:pathway_sections).where(pathway_sections: { pathway_id: @selected_pathway_id})
    @current_sections = current_user.sections.joins(:pathway_sections).distinct.where(pathway_sections: { pathway_id: @selected_pathway_id})

    # p @current_sections

    respond_to do |format|      
      format.html { render :home }  #fall back if render fails
      format.turbo_stream do 
        render turbo_stream:
        turbo_stream.update('active_sections_partial_div', partial: 'active_quests/active_sections', locals: { active_sections: @current_sections })
      end
    end
    
  end

  #called when a user chooses a new section from dropdown
  def refreshSection
    # p params
    # p params[:select_section]

    @selected_section_id = params[:select_section]
    @selected_pathway_id = params[:selected_pathway]

    # current_tasks = Task.joins(:section_tasks).where(section_tasks: { section_id: @selected_section_id})
    @current_tasks = current_user.tasks.joins(:section_tasks).distinct.where(section_tasks: { section_id: @selected_section_id}).select('tasks.*,user_tasks.*,section_tasks.*').order(:step_number);
    # current_tasks = current_user.tasks.joins(:user_tasks).select('tasks.*,user_tasks.*');

    @selected_map = QuestMap.where(size: @current_tasks.length).first

    # p "CURRENT TASKS"
    # p @current_tasks

    respond_to do |format|      
      format.html { render :home }  #fall back if render fails
      format.turbo_stream do 
        render turbo_stream:
        turbo_stream.update('active_tasks_partial_div', partial: 'active_quests/active_tasks', locals: { active_tasks: @current_tasks, map: @selected_map })
      end
    end
    
  end

  #called when a user completes/updates a task
  def updateTask
    # p params
    # p params[:task_to_update]
    selected_pathway_id = params[:selected_pathway]
    selected_section_id = params[:select_section]
    
    taskProgress = UserTask.where(task_id: params[:task_to_update]).where(user_id: current_user.id).first

    if taskProgress.progress != "completed"
      progress = 2
      UserTask.where(task_id: params[:task_to_update]).where(user_id: current_user.id).update_all(progress: 2)
      # flash.now[:notice] = "Task completed!"
    else
      progress = 1
      UserTask.where(task_id: params[:task_to_update]).where(user_id: current_user.id).update_all(progress: 1)
      # flash.now[:notice] = "Task reverted!"
    end 

    #MARKING Modules AS COMPLETE
    current_tasks = current_user.tasks.joins(:section_tasks).distinct.where(section_tasks: { section_id: selected_section_id}).select('tasks.*,user_tasks.*');
    # p current_tasks

    count = 0
    #Check if there are any outstanding tasks for this module
    current_tasks.each do |task|
      if task.progress != 2
        count = count + 1
      end
    end

    # p "BEFORE MODULE CHANGE, SECTION COUNT:"
    # p count
    
    # p current_user.user_sections.where(section_id: selected_section_id)
    #If this was the last task to complete. Mark the module as complete.
    if count == 0
      current_user.user_sections.where(section_id: selected_section_id).update_all(progress: 2)
    end

    # p "AFTER MODULE CHANGE, SECTION COUNT:"
    # p current_user.user_sections.where(section_id: selected_section_id)

    
    #MARKING Pathways AS COMPLETE
    current_sections = current_user.sections.joins(:pathway_sections).distinct.where(pathway_sections: { pathway_id: selected_pathway_id}).select('sections.*,user_sections.*');
    # p current_sections

    count = 0
    #Check if there are any outstanding modules for this pathway
    current_sections.each do |section|
      if section.progress != 2
        count = count + 1
      end
    end

    # p "BEFORE PATHWAY CHANGE, SECTION COUNT:"
    # p count
    # p current_user.user_pathways.where(pathway_id: selected_pathway_id)

    #If this was the last section to complete. 
    if count == 0
      #Mark the pathway as complete.
      current_user.user_pathways.where(pathway_id: selected_pathway_id).update(progress: 2)

      #GRANT Equipent ON COMPLETION
    
      #find the equipment item relating to the pathway
      if Equipment.where(pathway_id: selected_pathway_id).exists?
        reward_equipment = Equipment.where(pathway_id: selected_pathway_id).first
      end

      #check if equipment has already been granted, if not, grant it.
      if !current_user.user_equipments.where(equipment_id: reward_equipment.id).exists?
        UserEquipment.create(:user_id => current_user.id, :equipment_id => reward_equipment.id)
        @reward_image = reward_equipment.icon
        flash.now[:notice] = "You have earnt a new item reward: '#{reward_equipment.name}' !"
      end

    end

    # p "AFTER PATHWAY CHANGE"

    # p current_user.user_pathways.where(pathway_id: selected_pathway_id)  

    respond_to do |format|      
      format.html { render :home }  #fall back if render fails
      format.turbo_stream do 
        render turbo_stream:[
        turbo_stream.update('task_status_partial_div-' + params[:task_to_update], partial: 'active_quests/task_status', locals: { task_status: progress }),
        turbo_stream.replace("flash-messages", partial: "layouts/flash")]
      end
    end

  end

  def update_map_task 
    @selected_pathway_id = params[:selected_pathway]
    @selected_section_id = params[:select_section]

    task = current_user.tasks.distinct.where(tasks: {id: params[:selected_task]}).select('tasks.*,user_tasks.*').first;
    respond_to do |format|      
      format.html { render :active_quests }
      format.turbo_stream do 
        render turbo_stream:
          turbo_stream.update('map-task-display',
                              partial: 'active_quests/task',
                              locals: { task: task })
      end
    end
  end

  def update
  end

  def search
  end
end
