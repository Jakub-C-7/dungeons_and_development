class AddEquippedToUserEquipments < ActiveRecord::Migration[7.1]
  def change
    add_column :user_equipments, :equipped, :boolean, default: :false
  end
end
