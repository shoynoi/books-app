class AddUserIdToReports < ActiveRecord::Migration[5.2]
  def up
    execute "DELETE FROM reports;"
    add_column :reports, :user_id, :integer
    change_column :reports, :user_id, :integer, null: false
    add_index :reports, :user_id
  end

  def down
    remove_index :reports, :user_id
    remove_column :reports, :user_id
  end
end
