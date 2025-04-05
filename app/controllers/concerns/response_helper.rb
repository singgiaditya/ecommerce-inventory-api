module ResponseHelper
  # success response
  def render_success(data, status = :ok)
    render json: { status: get_status_message(status), body: data }, status: status
  end
  # create success response
  def render_create(data, status = :created)
    render json: { status: get_status_message(status), body: data }, status: status
  end
  # error response
  def render_error(error = nil, message = "Validation Error", status = :unprocessable_content)
    render json: {
      status: get_status_message(status),
      message: message,
      error: error
    }, status: status
  end

  private

  def get_status_message(status)
    status_code = Rack::Utils::SYMBOL_TO_STATUS_CODE[status]
    status_string = Rack::Utils::HTTP_STATUS_CODES[status_code]
    status_message = "#{status_code} #{status_string}"
    status_message
  end
end
