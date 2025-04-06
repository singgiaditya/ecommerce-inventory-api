module ResponseHelper
  # success response
  def render_success(message, data, status = :ok, success = true)
    render json: { success:, message:, data: }, status: status
  end
  # error response
  def render_error(error, status = :unprocessable_entity, success = false)
    render json: {
      success:,
      error:
    }, status: status
  end
end
