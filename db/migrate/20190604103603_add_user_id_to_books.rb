class AddUserIdToBooks < ActiveRecord::Migration[5.2]
  def up
    execute "DELETE FROM books;"
    add_column :books, :user_id, :integer
    change_column :books, :user_id, :integer, null: false
    add_index :books, :user_id
  end

  def down
    remove_index :books, :user_id
    remove_column :books, :user_id
  end
end
