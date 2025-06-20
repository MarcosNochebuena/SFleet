module ErrorHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound do |e|
      render_error(:not_found, e.message)
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      render_error(:unprocessable_entity, "Validation failed", e.record.errors)
    end

    rescue_from ArgumentError do |e|
      render_error(:unprocessable_entity, e.message)
    end

    rescue_from ActionController::UnpermittedParameters do |e|
      render_error(:bad_request, "Unpermitted parameters: #{e.params.join(', ')}")
    end

    rescue_from ActionController::ParameterMissing do |e|
      render_error(:bad_request, e.message)
    end

    rescue_from ActionDispatch::Http::Parameters::ParseError, JSON::ParserError do |e|
      render_error(:bad_request, "Invalid JSON format in request body")
    end

    rescue_from ActiveRecord::RecordNotUnique do |e|
      render_error(:conflict, "Resource already exists")
    end

    rescue_from ActiveRecord::StatementInvalid do |e|
      render_error(:unprocessable_entity, "Database error occurred")
    end

  end

  private

  def render_error(status, message, details = nil)
    response = { error: { code: Rack::Utils.status_code(status), message: message } }
    response[:error][:details] = details if details
    render json: response, status: status
  end
end
