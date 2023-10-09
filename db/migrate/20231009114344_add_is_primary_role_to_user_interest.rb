class AddIsPrimaryRoleToUserInterest < ActiveRecord::Migration[7.1]
  def change
    add_column :user_interests, :isPrimaryRole, :boolean, default: false

  end
end
