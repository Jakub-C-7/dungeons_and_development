class CreatePathwaySections < ActiveRecord::Migration[7.1]
  def change
    create_table :pathway_sections do |t|
      t.references :section, null: false, foreign_key: true
      t.references :pathway, null: false, foreign_key: true
      t.integer :step_number

      t.timestamps
    end
    add_index :pathway_sections, [:section_id, :pathway_id], unique: true
  end
end
