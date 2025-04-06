class UserController < ApplicationController
  def create
    if User.exists?(email: params[:email])
      return render_error("Email already registered", :conflict)
    end
    @user = User.new(user_params)
    if @user.save
      render_success("New user has been created", { user: @user }, :created)
    else
      render_error(@user.errors.full_messages)
    end
  end

  def index
    @users = User.all
    render_success("Data found", { users: @users })
  end

  private

  def user_params
    params.permit(:email, :password, :name)
  end
end
