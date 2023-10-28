class CreateEquipment < ActiveRecord::Migration[7.1]
  def change
    create_table :equipment do |t|
      t.references :pathway, null: false, foreign_key: true
      t.string :name
      t.string :description
      t.string :icon
      t.integer :category

      t.timestamps
    end
  end
end
