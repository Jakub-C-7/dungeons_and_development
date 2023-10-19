class CreateTaskInterests < ActiveRecord::Migration[7.1]
  def change
    create_table :task_interests do |t|
      t.references :task, null: false, foreign_key: true
      t.references :interest, null: false, foreign_key: true

      t.timestamps
    end
    add_index :task_interests, [:task_id, :interest_id], unique: true
  end
end
