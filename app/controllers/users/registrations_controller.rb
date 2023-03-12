class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def create
    todo_user = TodoUser.new(sign_up_params)

    if todo_user.save
      render json: {todo_user: todo_user, message: 'sign up success', is_success: 		true}, status: :ok
    else
      render json: {message: 'Sign up failed', is_success: false}, 				status: :unprocessable_entity
    end
  end

  private

  def respond_with(resource, _opts = {})
    register_success && return if resource.persisted?

    register_failed
  end

  def register_success
    render json: { message: 'Signed up sucessfully.' }
  end

  def register_failed
    render json: { message: "Something went wrong." }
  end
end
