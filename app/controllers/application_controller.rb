class ApplicationController < ActionController::API
  include ResponseHelper

  before_action :authenticate

  rescue_from JWT::VerificationError, with: :missing_invalid_token
  rescue_from JWT::DecodeError, with: :missing_invalid_token

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
end
