class PasswordsController < Devise::PasswordsController
  def create
    user = TodoUser.find_by(email: params[:email])
    if user.present?
      user.send_reset_password_instructions
      render json: { message: 'Reset password instructions sent.' }
    else
      render json: { error: 'User not found.' }, status: :not_found
    end
  end

  def edit
    puts 'TEST'
    @reset_password_token = params[:reset_password_token]
    #render json: { message: 'Test' }
    render file: "public/reset_password.html", layout: false
  end

  def update
    self.resource = resource_class.reset_password_by_token(resource_params)
    if resource.errors.empty?
      render json: { message: 'Password updated.' }
    else
      render json: { error: resource.errors.full_messages.join(', ') }, status: :unprocessable_entity
    end
  end
end
