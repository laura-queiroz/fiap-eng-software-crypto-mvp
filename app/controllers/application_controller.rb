# frozen_string_literal: true

class ApplicationController < ActionController::API
  include ActionController::MimeResponds
  include ActionController::Rendering
  include ActionView::Layouts

  layout "application"

  protected

  def render_not_found(message = "Not found")
    respond_to do |format|
      format.json { render json: { error: message }, status: :not_found }
      format.html { render plain: message, status: :not_found }
    end
  end

  def render_validation_errors(errors, status: :unprocessable_entity)
    payload = errors.is_a?(Hash) ? { errors: errors } : { errors: errors }
    respond_to do |format|
      format.json { render json: payload, status: status }
      format.html { render :new, layout: "application", status: status }
    end
  end

  def render_resource_error(message, status: :unprocessable_entity)
    respond_to do |format|
      format.json { render json: { error: message }, status: status }
      format.html { render :new, layout: "application", status: status }
    end
  end

  def render_service_failure(result)
    case result.error_code
    when :not_found
      render_not_found(result.errors)
    when :cryptocurrency_not_found
      render_resource_error(result.errors)
    else
      render_validation_errors(result.errors)
    end
  end
end
