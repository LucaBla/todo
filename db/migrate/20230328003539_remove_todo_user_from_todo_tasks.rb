class RemoveTodoUserFromTodoTasks < ActiveRecord::Migration[7.0]
  def change
    #remove_reference :todo_tasks, :todo_user, foreign_key: true
    remove_index :todo_tasks, :todo_user_id
    #Ex:- add_index("admin_users", "username")
    remove_column :todo_tasks, :todo_user_id, :bigint
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
