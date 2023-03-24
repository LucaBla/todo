class AddIndexToTask < ActiveRecord::Migration[7.0]
  def change
    add_column :todo_tasks, :todo_user_id, :bigint
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
    add_index :todo_tasks, :todo_user_id
    #Ex:- add_index("admin_users", "username")
  end
end
