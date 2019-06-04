class AddUserIdToComments < ActiveRecord::Migration[5.2]
  def up
    execute "DELETE FROM comments;"
    add_column :comments, :user_id, :integer
    change_column :comments, :user_id, :integer, null: false
    add_index :comments, :user_id
  end

  def down
    remove_index :comments, :user_id
    remove_column :comments, :user_id
  end
end
