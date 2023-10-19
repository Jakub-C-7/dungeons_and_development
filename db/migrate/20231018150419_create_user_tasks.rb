class CreateUserTasks < ActiveRecord::Migration[7.1]
  def change
    create_table :user_tasks do |t|
      t.references :user, null: false, foreign_key: true
      t.references :task, null: false, foreign_key: true
      t.integer :progress
      t.datetime :last_updated
      t.integer :rating

      t.timestamps
    end
    add_index :user_tasks, [:user_id, :task_id], unique: true
  end
end
