class ActiveQuestsController < ApplicationController
  def home
    @currently_active_pathways = current_user.pathways;
    # @current_pathways = current_user.user_pathways.where(progress: "started");
    # @current_pathways = current_user.user_pathways.where(progress: "started").joins(:pathway).order(:id);
    @current_pathways = current_user.user_pathways.joins(:pathway).where(progress: "started").select('pathways.*,user_pathways.*');

    @currently_active_sections = current_user.sections.pluck(:id, :name, :description);
    @currently_active_tasks = current_user.tasks.pluck(:id, :name, :description);

  end

  def show
  end

  def update
  end

  def search
  end
end
