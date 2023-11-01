class AddCoordinatesArrayToQuestmap < ActiveRecord::Migration[7.1]
  def change
    add_column :quest_maps, :coordinates_left, :integer, array: true, default: []
    add_column :quest_maps, :coordinates_bot, :integer, array: true, default: []
  end
end
