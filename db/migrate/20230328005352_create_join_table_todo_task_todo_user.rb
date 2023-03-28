class CreateJoinTableTodoTaskTodoUser < ActiveRecord::Migration[7.0]
  def change
    create_join_table :todo_tasks, :todo_users do |t|
      t.index :todo_task_id
      t.index :todo_user_id
    end
  end
end
