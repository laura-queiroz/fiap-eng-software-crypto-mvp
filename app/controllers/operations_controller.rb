# frozen_string_literal: true

class OperationsController < ApplicationController
  PERMITTED_PARAMS = %i[cryptocurrency_id operation_type amount].freeze

  def index
    list = OperationRepository.all.map(&:to_h)
    @operations = list
    respond_to do |format|
      format.json { render json: list }
      format.html { render :index, layout: "application" }
    end
  end

  def show
    op = OperationRepository.find(params[:id])
    if op
      render json: op.to_h
    else
      render_not_found
    end
  end

  def new
    render :new, layout: "application"
  end

  def create
    result = Operations::CreateService.call(operation_params)

    if result.success?
      respond_to do |format|
        format.json { render json: result.data.to_h, status: :created }
        format.html { redirect_to operations_path, status: :see_other }
      end
    else
      render_service_failure(result)
    end
  end

  private

  def operation_params
    params.permit(PERMITTED_PARAMS).to_h.symbolize_keys
  end
end
