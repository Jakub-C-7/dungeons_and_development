class CreateCharacterSelections < ActiveRecord::Migration[7.1]
  def change
    create_table :character_selections do |t|
      t.string :url

      t.timestamps
    end
  end
end
