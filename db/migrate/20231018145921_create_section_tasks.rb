class CreateSectionTasks < ActiveRecord::Migration[7.1]
  def change
    create_table :section_tasks do |t|
      t.references :section, null: false, foreign_key: true
      t.references :task, null: false, foreign_key: true
      t.integer :step_number

      t.timestamps
    end
    add_index :section_tasks, [:section_id, :task_id], unique: true
  end
end
