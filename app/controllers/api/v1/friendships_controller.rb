class Api::V1::FriendshipsController < ApplicationController
  before_action :set_friendship, only: %i[ update]
  before_action :authenticate_todo_user!

  def index
    @friendships = current_todo_user.friends.order(:email)

    render json: @friendships
  end

  def create
    friend = TodoUser.find_by(email: friendship_params[:friend_email].downcase)

    if current_todo_user.friends.include?(friend) #or already has send request
      render json: { message: 'Friendship already exists' }, status: :unprocessable_entity
    else
      if Friendship.befriend(current_todo_user, friend)
        render json: { message: 'created'}, status: :created
      else
        render json: { message: 'failed to create'}, status: :unprocessable_entity
      end
    end
  end

  def update
    if @friendship.update(accepted: friendship_params[:accepted])
      symmetric_friendship = @friendship.find_symmetric_friendship
      symmetric_friendship.update(accepted: friendship_params[:accepted]) if symmetric_friendship
      render json: @friendship
    else
      render json: @friendship.errors, status: :unprocessable_entity
    end
  end

  #accepts friend_id and destroys the friendship with current_todo_user
  #or
  #aceppts friendship_id and destroy the friendship
  def destroy
    if(params.has_key?(:id))
      set_friendship()
    elsif(friend_id_params.has_key?(:friend_id))
      @friendship = current_todo_user.friendships.find_by(friend_id: friend_id_params[:friend_id])
    else
      render json: {
        message: "Invalid Params"
      }, status: :unprocessable_entity
      return
    end
    if @friendship == nil
      render json: {
        message: "Couldnt find friendship"
      }, status: :unprocessable_entity
      return
    end
    symmetric_friendship = @friendship.find_symmetric_friendship
    @friendship.destroy
    symmetric_friendship.destroy if symmetric_friendship

    render json: {
      message: "Friendship has been successfully destroyed"
    }, status: :ok
  end

  private

  def set_friendship
    @friendship = current_todo_user.friendships.find(params[:id])
  end

  def friendship_params
    params.require(:friendship).permit(:friend_email, :accepted)
  end

  def friend_id_params
    params.require(:friendship).permit(:friend_id)
  end
end
