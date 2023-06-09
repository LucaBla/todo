class PasswordsController < Devise::PasswordsController
  respond_to :html

  def create
    user = TodoUser.find_by(email: params[:email].downcase)
    if user.present?
      user.send_reset_password_instructions
      render json: { message: 'Reset password instructions sent.' }
    else
      render json: { error: 'User not found.' }, status: :not_found
    end
  end

  def edit
    super
    # @reset_password_token = params[:reset_password_token]
    # html1 = "<html><head></head><body><h1>Holololo</h1></body></html>".html_safe#, :content_type => 'text/html'
    # render file: "#{Rails.root}/public/reset_password.html",  layout: false
    #render json: { message: 'Test' }
    #render file: "public/reset_password.html", layout: false
    #render "public/reset_password.html"
  end

  def update
    #super
    self.resource = resource_class.reset_password_by_token(resource_params)
    if resource.errors.empty?
      render json: { message: 'Password updated.' }
    else
      render json: { error: resource.errors.full_messages.join(', ') }, status: :unprocessable_entity
    end
  end
end
