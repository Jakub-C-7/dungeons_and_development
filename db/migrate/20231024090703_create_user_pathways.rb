class CreateUserPathways < ActiveRecord::Migration[7.1]
  def change
    create_table :user_pathways do |t|
      t.references :user, null: false, foreign_key: true
      t.references :pathway, null: false, foreign_key: true
      t.integer :progress
      t.datetime :last_updated
      t.integer :rating

      t.timestamps
    end
    add_index :user_pathways, [:user_id, :pathway_id], unique: true
  end
end
