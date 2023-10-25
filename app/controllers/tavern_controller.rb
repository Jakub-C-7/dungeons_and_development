class TavernController < ApplicationController
  def home
  end

   #IN SERIOUS NEED OF REWORKING#


  def retrieve_quest_interests(sectionQuests, pathwayQuests)
    pathwayQuests.each do |q|
      q['interests'] = Interest.joins(:pathway_interests).where(pathway_interests: { pathway_id: q['id']}).pluck(:name)
    end
    sectionQuests.each do |q|
      q['interests'] = Interest.joins(:section_interests).where(section_interests: { section_id: q['id']}).pluck(:name)
    end
    @quests = pathwayQuests + sectionQuests
  end

  def quest_board
    @selected_interests = current_user.interests.pluck(:id)
    @interests = Interest.all
    @recommendedQuests = Pathway.order("RANDOM()").first(3)

    pathwayQuests = Pathway.joins(:pathway_interests).where(pathway_interests: { interest_id: @selected_interests }).order(:name).as_json
    sectionQuests = Section.joins(:section_interests).where(section_interests: { interest_id: @selected_interests }).order(:name).as_json 
    retrieve_quest_interests(sectionQuests, pathwayQuests)

  end

  def update_recommended
      p params[:selected_quest]
      quest  = Pathway.find(params[:selected_quest]).as_json
      quest['interests'] = Interest.joins(:pathway_interests).where(pathway_interests: { pathway_id: quest['id']}).pluck(:name)
     
      respond_to do |format|      
        format.html { render :quest_board }
        format.turbo_stream do 
          render turbo_stream:
            turbo_stream.update('recommended-quest-display',
                                partial: 'tavern/quest',
                                locals: { quest: quest })
        end
      end

  end



  def search_quests
    search_field = params[:search].present? ? params[:search] : ""
#
    if params[:interests].present? then
      if params[:category] == "1" then
        quests = Pathway.where("name ILIKE ?", "%" + search_field + "%").joins(:pathway_interests).where(pathway_interests: { interest_id: params[:interests] }).order(:name).as_json
        retrieve_quest_interests([], quests)
      elsif params[:category] == "2" then
        quests = Section.where("name ILIKE ?", "%" + search_field + "%").joins(:section_interests).where(section_interests: { interest_id: params[:interests] }).order(:name).as_json
        retrieve_quest_interests(quests, [])
      else
        sectionQuests = Section.where("name ILIKE ?", "%" + search_field + "%").joins(:section_interests).where(section_interests: { interest_id: params[:interests] }).order(:name).as_json
        pathwayQuests = Pathway.where("name ILIKE ?", "%" + search_field + "%").joins(:pathway_interests).where(pathway_interests: { interest_id: params[:interests] }).order(:name).as_json
        retrieve_quest_interests(sectionQuests, pathwayQuests)
      end
    else
      if params[:category] == "1" then
        quests = Pathway.where("name ILIKE ?", "%" + search_field + "%").order(:name).as_json
        retrieve_quest_interests([], quests)
      elsif params[:category] == "2" then
        quests = Section.where("name ILIKE ?", "%" + search_field + "%").order(:name).as_json        
        retrieve_quest_interests(quests, [])
      else
        sectionQuests = Section.where("name ILIKE ?", "%" + search_field + "%").order(:name).as_json 
        pathwayQuests = Pathway.where("name ILIKE ?", "%" + search_field + "%").order(:name).as_json 
        retrieve_quest_interests(sectionQuests, pathwayQuests)
      end
    end
    respond_to do |format|
      format.html { render :quest_board }
      format.turbo_stream do 
        render turbo_stream:
          turbo_stream.update('quests',
                              partial: 'tavern/quests',
                              locals: { quests: @quests })
          
      end
    end

  end
end
