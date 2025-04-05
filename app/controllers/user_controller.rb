class UserController < ApplicationController
  def create
    if User.exists?(email: params[:email])
      return render_error(nil, "Email already registered", :conflict)
    end
    @user = User.new(user_params)
    if @user.save
      render_create({ user: @user.as_json })
    else
      render_error(@user.errors.full_messages)
    end
  end

  def index
    users = User.all
    render_success({ users: })
  end

  private

  def user_params
    params.permit(:email, :password, :name)
  end
end
