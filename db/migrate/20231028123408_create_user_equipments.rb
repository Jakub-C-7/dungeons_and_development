class CreateUserEquipments < ActiveRecord::Migration[7.1]
  def change
    create_table :user_equipments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :equipment, null: false, foreign_key: true

      t.timestamps
    end
  end
end
