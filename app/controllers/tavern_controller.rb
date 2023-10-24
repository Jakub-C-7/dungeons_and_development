class TavernController < ApplicationController
  def home
  end

  def quest_board
     @quests = Section.all.order(:name) + Pathway.all.order(:name)
  end


  def search_quests
    search_field = params[:search].present? ? params[:search] : ""

    @quests = Section.where("name ILIKE ?", "%" + search_field + "%") + Pathway.where("name ILIKE ?", "%" + search_field + "%") 
    p "HELLO"
    p @quests
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
