class AddIndexToUsers < ActiveRecord::Migration[5.2]
  def change
    change_column_null :users, :username, false

    add_index :users, :username, unique: true
  end
end