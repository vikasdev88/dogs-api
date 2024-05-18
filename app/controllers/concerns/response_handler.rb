# frozen_string_literal: true

module ResponseHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActionController::InvalidAuthenticityToken, with: :handle_invalid_authenticity_token
    rescue_from StandardError, with: :render_internal_server_error
  end

  private

  def handle_invalid_authenticity_token
    message = I18n.t("errors.invalid_authenticity_token_message")
    render json: { errors: message }, status: :unauthorized
  end

  def record_not_found(message)
    render json: { success: false, errors: message }, status: :not_found
  end

  def render_json_response(response)
    render json: response, status: response[:code]
  end

  def render_internal_server_error(_err)
    message = I18n.t("errors.internal_server_error")
    render json: { errors: message }, status: :internal_server_error
  end
end
