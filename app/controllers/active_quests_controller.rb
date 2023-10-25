class ActiveQuestsController < ApplicationController
  def home
    # @currently_active_pathways = current_user.pathways;
    # @current_pathways = current_user.user_pathways.where(progress: "started");
    # @current_pathways = current_user.user_pathways.where(progress: "started").joins(:pathway).order(:id);
    @current_pathways = current_user.user_pathways.joins(:pathway).where(progress: "started").select('pathways.*,user_pathways.*');
    # @latest_pathway = current_user.user_pathways.joins(:pathway).where(progress: "started").select('pathways.*,user_pathways.*').order(:id).pluck(:id);

    # @currently_active_sections = current_user.sections.pluck(:id, :name, :description);
    # @currently_active_tasks = current_user.tasks.pluck(:id, :name, :description);

  end

  #called when a user chooses a new pathway by clicking a pathway button
  def refreshPathway
    p params
    p params[:selected_pathway]

    # @selected_pathway_id = params[:selected_pathway]
    @selected_pathway_id = '1'

    # @current_sections = Section.joins(:pathway_sections).where(pathway_sections: { pathway_id: @selected_pathway_id})
    @current_sections = current_user.sections.joins(:user_sections).joins(:pathway_sections).distinct.where(pathway_sections: { pathway_id: @selected_pathway_id})

    p @current_sections

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
    p params
    p params[:select_section]

    @selected_section_id = params[:select_section]

    # current_tasks = Task.joins(:section_tasks).where(section_tasks: { section_id: @selected_section_id})
    current_tasks = current_user.tasks.joins(:user_tasks).joins(:section_tasks).distinct.where(section_tasks: { section_id: @selected_section_id})

    p current_tasks
    
    # current_sections = Section.joins(:pathway_sections).where(pathway_sections: { pathway_id: '1'})

    respond_to do |format|      
      format.html { render :home }  #fall back if render fails
      format.turbo_stream do 
        render turbo_stream:
        turbo_stream.update('active_tasks_partial_div', partial: 'active_quests/active_tasks', locals: { active_tasks: current_tasks })
      end
    end
    
  end

  def update
  end

  def search
  end
end
