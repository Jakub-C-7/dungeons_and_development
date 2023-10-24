class TavernController < ApplicationController
  def home
  end

  def quest_board
    @selected_interests = current_user.interests.pluck(:id)
    @interests = Interest.all
    @quests = Section.joins(:section_interests).where(section_interests: { interest_id: @selected_interests }).order(:name) + Pathway.joins(:pathway_interests).where(pathway_interests: { interest_id: @selected_interests }).order(:name)
  end


  def search_quests
    search_field = params[:search].present? ? params[:search] : ""
#
    if params[:interests].present? then
      if params[:category] == "1" then
        @quests = Pathway.where("name ILIKE ?", "%" + search_field + "%").joins(:pathway_interests).where(pathway_interests: { interest_id: params[:interests] }).order(:name)
      elsif params[:category] == "2" then
        @quests = Section.where("name ILIKE ?", "%" + search_field + "%").joins(:section_interests).where(section_interests: { interest_id: params[:interests] }).order(:name)
      else
        @quests = Section.where("name ILIKE ?", "%" + search_field + "%").joins(:section_interests).where(section_interests: { interest_id: params[:interests] }).order(:name) + Pathway.where("name ILIKE ?", "%" + search_field + "%").joins(:pathway_interests).where(pathway_interests: { interest_id: params[:interests] }).order(:name)
      end
    else
      if params[:category] == "1" then
        @quests = Pathway.where("name ILIKE ?", "%" + search_field + "%").order(:name)
      elsif params[:category] == "2" then
        @quests = Section.where("name ILIKE ?", "%" + search_field + "%").order(:name)
      else
        @quests = Section.where("name ILIKE ?", "%" + search_field + "%").order(:name) + Pathway.where("name ILIKE ?", "%" + search_field + "%").order(:name)
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
