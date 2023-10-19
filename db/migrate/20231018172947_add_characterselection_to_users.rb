class AddCharacterselectionToUsers < ActiveRecord::Migration[7.1]
  def change
    add_reference :users, :character_selection, null: true, foreign_key: true
  end
end
