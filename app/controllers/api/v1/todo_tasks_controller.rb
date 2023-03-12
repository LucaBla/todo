class Api::V1::TodoTasksController < ApplicationController
  before_action :set_todo_task, only: %i[ show update destroy ]
  #before_action :authenticate_todo_user!

  def index
    @todo_tasks = TodoTask.all

    render json: @todo_tasks
  end

  def show
    render json: @todo_task
  end

  def create
    @todo_task = TodoTask.new(todo_task_params)
    if @todo_task.save
      render json: @todo_task, status: :created
    else
      render json: @todo_task.error, status: :failed
    end
  end

  def update
    if @todo_task.update(todo_task_params)
      render json: @todo_task
    else
      render json: @todo_task.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @todo_task.destroy

    render json: {
      message: "Task has been successfully destroyed"
    }, status: :ok
  end
  
  private

  def set_todo_task
    @todo_task = TodoTask.find(params[:id])
  end

  def todo_task_params
    params.require(:todo_task).permit(:title, :description, :reminder, :deadline, :finished)
  end

end
