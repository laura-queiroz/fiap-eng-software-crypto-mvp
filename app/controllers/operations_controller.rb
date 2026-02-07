# frozen_string_literal: true

class OperationsController < ApplicationController
  def index
    list = Repositories::InMemoryStore.operations.map(&:to_h)
    @operations = list
    respond_to do |format|
      format.json { render json: list }
      format.html { render :index, layout: "application" }
    end
  end

  def show
    op = Repositories::InMemoryStore.find_operation(params[:id])
    if op
      render json: op.to_h
    else
      render json: { error: "Not found" }, status: :not_found
    end
  end

  def new
    render :new, layout: "application"
  end

  def create
    cryptocurrency_id = params[:cryptocurrency_id].to_i
    crypto = Repositories::InMemoryStore.find_cryptocurrency(cryptocurrency_id)
    unless crypto
      respond_to do |format|
        format.json { render json: { error: "Cryptocurrency not found" }, status: :unprocessable_entity }
        format.html { render :new, layout: "application", status: :unprocessable_entity }
      end
      return
    end
    attrs = {
      cryptocurrency_id: cryptocurrency_id,
      operation_type: params[:operation_type],
      amount: params[:amount].to_f,
      cryptocurrency_price: crypto.price,
      operation_date: Time.now
    }
    op = Operation.new(attrs)
    unless op.valid?
      respond_to do |format|
        format.json { render json: { errors: "operation_type (buy/sell) and amount required" }, status: :unprocessable_entity }
        format.html { render :new, layout: "application", status: :unprocessable_entity }
      end
      return
    end
    op.id = Repositories::InMemoryStore.next_operation_id
    Repositories::InMemoryStore.operations << op
    respond_to do |format|
      format.json { render json: op.to_h, status: :created }
      format.html { redirect_to operations_path, status: :see_other }
    end
  end
end
