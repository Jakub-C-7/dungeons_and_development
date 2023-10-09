class AddUniquenessConstraintToUserInterests < ActiveRecord::Migration[7.1]
  def change
    add_index :user_interests, [:user_id, :interest_id], unique: true, name: 'unique_interest_per_user'
  end
end
