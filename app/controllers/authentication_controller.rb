class AuthenticationController < ApplicationController
  skip_before_action :authenticate

  def login
    if params[:email].blank? || params[:password].blank?
      return render_error("Email and password cannot be blank")
    end

    user = User.find_by(email: params[:email])
    authenticated_user = user&.authenticate(params[:password])

    if authenticated_user
      token = JsonWebToken.encode(user_id: user.id)

      render_success("User Logged in successfully", { token: })
    else
      render_error("Invalid email or password", :unauthorized)
    end
  end
end
