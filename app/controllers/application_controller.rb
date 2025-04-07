class ApplicationController < ActionController::API
  include ResponseHelper
  include PaginationHelper

  before_action :authenticate

  rescue_from JWT::VerificationError, with: :missing_invalid_token
  rescue_from JWT::DecodeError, with: :missing_invalid_token
  rescue_from ActionController::ParameterMissing, with: :handle_missing_param
  rescue_from ActiveRecord::RecordNotFound, with: :handle_data_not_found

  private

  def authenticate
    authorization_header = request.headers["Authorization"]
    token = authorization_header.split(" ").last if authorization_header
    decoded_token = JsonWebToken.decode(token)

    User.find(decoded_token[:user_id])
  end

  def missing_invalid_token
    render_error("Missing or invalid token", :unauthorized)
  end

  def handle_missing_param(exception)
    render_error(exception.message, :bad_request)
  end

  def handle_data_not_found(exception)
    render_error(exception.message, :not_found)
  end
end
