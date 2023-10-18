class CreateSectionInterests < ActiveRecord::Migration[7.1]
  def change
    create_table :section_interests do |t|
      t.references :section, null: false, foreign_key: true
      t.references :interest, null: false, foreign_key: true

      t.timestamps
    end
    add_index :section_interests, [:section_id, :interest_id], unique: true
  end
end
