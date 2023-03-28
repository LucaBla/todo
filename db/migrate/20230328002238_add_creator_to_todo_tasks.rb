class AddCreatorToTodoTasks < ActiveRecord::Migration[7.0]
  def change
    add_reference :todo_tasks, :creator, null: false, foreign_key: {to_table: :todo_users}
  end
end
