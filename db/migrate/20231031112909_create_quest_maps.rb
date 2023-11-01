class CreateQuestMaps < ActiveRecord::Migration[7.1]
  def change
    create_table :quest_maps do |t|
      t.string :image
      t.integer :size

      t.timestamps
    end
  end
end
