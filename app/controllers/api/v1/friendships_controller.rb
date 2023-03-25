class Api::V1::FriendshipsController < ApplicationController
  before_action :set_friendship, only: %i[ update destroy ]
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
        render json: { message: 'failed to create'}, status: :failed
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

  private

  def set_friendship
    @friendship = current_todo_user.friendships.find(params[:id])
  end

  def friendship_params
    params.require(:friendship).permit(:friend_email, :accepted)
  end
end
