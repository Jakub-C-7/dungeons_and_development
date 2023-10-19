class CreatePathwayInterests < ActiveRecord::Migration[7.1]
  def change
    create_table :pathway_interests do |t|
      t.references :pathway, null: false, foreign_key: true
      t.references :interest, null: false, foreign_key: true

      t.timestamps
    end
    add_index :pathway_interests, [:pathway_id, :interest_id], unique: true
  end
end
