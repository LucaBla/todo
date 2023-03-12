class CreateTodoTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :todo_tasks do |t|
      t.string :title
      t.text :description
      t.date :reminder
      t.date :deadline
      t.boolean :finished

      t.timestamps
    end
  end
end
