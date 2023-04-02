class Api::V1::TodoTasksController < ApplicationController
  before_action :set_todo_task, only: %i[ show update destroy creator participants ]
  before_action :authenticate_todo_user!

  def index
    # @todo_tasks = current_todo_user.todo_tasks.where('deadline >= ?', Date.yesterday)
    #                       .or(current_todo_user.todo_tasks.where(deadline: nil))
    #                       .or(current_todo_user.todo_tasks.where(isAnytime: true))
    #                       .order(:isAnytime, :deadline, :finished, :title)
    all_todo_tasks= current_todo_user.all_todo_tasks

    # @todo_tasks = all_todo_tasks.where('deadline >= ?', Date.yesterday)
    #                             .or(all_todo_tasks.where(deadline: nil))
    #                             .or(all_todo_tasks.where(isAnytime: true))
    #                             .order(:isAnytime, :deadline, :finished, :title)
    @todo_tasks = all_todo_tasks.order(isAnytime: :desc, deadline: :asc, finished: :asc, title: :asc)
    

    render json: @todo_tasks
  end

  def log
    @todo_tasks = current_todo_user.all_todo_tasks.where('deadline < ?', Date.yesterday).order(:deadline, :finished, :title)

    render json: @todo_tasks
  end

  def creator
    @creator = @todo_task.creator

    render json: @creator
  end

  def participants
    @participants = @todo_task.participants

    render json: @participants
  end

  def show
    render json: @todo_task
  end

  def create
    #@todo_task = TodoTask.new(todo_task_params)
    @todo_task = current_todo_user.created_todo_tasks.create(todo_task_params)
    if(params[:todo_task][:participants_id].present?)
      @todo_task.participants = current_todo_user.friends.where(id: params[:todo_task][:participants_id])
    end
    if @todo_task.save
      render json: @todo_task, status: :created
    else
      render json: @todo_task.error, status: :failed
    end
  end

  def update
    if(params[:todo_task][:participants_id].present?)
      @todo_task.participants = current_todo_user.friends.where(id: params[:todo_task][:participants_id])
    end
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
    @todo_task = current_todo_user.all_todo_tasks.find(params[:id])
  end

  def todo_task_params
    params.require(:todo_task)
          .permit(:title, :description, :reminder, :deadline, :finished, :isAnytime)
  end

end
