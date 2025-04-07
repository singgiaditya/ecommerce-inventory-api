class UserController < ApplicationController
  before_action :set_user, only: %i[ show update destroy ]

  # POST /user
  def create
    if User.exists?(email: user_params[:email])
      return render_error("Email already registered", :conflict)
    end
    @user = User.new(user_params)
    if @user.save
      render_success("New user has been created", { user: @user }, :created)
    else
      render_error(@user.errors.full_messages)
    end
  end

  # GET /user
  def index
    @pagy, @users = paginate(User.all)

    render_success("Data found",{
      **pagy_metadata(@pagy),
      users: @users
    })
  end

  # GET /user/1
  def show
    render_success("Data found", { user: @user })
  end

  # PATCH/PUT /user/1
  def update
    if @user.update(user_params)
      render_success("User updated successfully", { user: @user })
    else
      render_error(@user.errors.full_messages)
    end
  end

  # DELETE /user/1
  def destroy
    @user.destroy!
    render_success("user deleted successfully", {})
  rescue ActiveRecord::RecordNotDestroyed => e
    render_error(e.record.errors.full_messages)
  end

  private

  def set_user
    @user = User.find(params.expect(:id))
  end

  def user_params
    params.permit(:email, :password, :name)
  end
end
