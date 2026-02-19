# frozen_string_literal: true

class CryptocurrenciesController < ApplicationController
  PERMITTED_PARAMS = %i[name symbol price image].freeze

  def index
    list = CryptocurrencyRepository.all.map(&:to_h)
    @cryptocurrencies = list
    respond_to do |format|
      format.json { render json: list }
      format.html { render :index, layout: "application" }
    end
  end

  def show
    crypto = CryptocurrencyRepository.find(params[:id])
    if crypto
      respond_to do |format|
        format.json { render json: crypto.to_h }
        format.html { render plain: crypto.to_h.inspect }
      end
    else
      render_not_found
    end
  end

  def new
    render :new, layout: "application"
  end

  def create
    result = Cryptocurrencies::CreateService.call(cryptocurrency_params)

    if result.success?
      respond_to do |format|
        format.json { render json: result.data.to_h, status: :created }
        format.html { redirect_to cryptocurrencies_path, status: :see_other }
      end
    else
      render_service_failure(result)
    end
  end

  def update
    result = Cryptocurrencies::UpdateService.call(params[:id], cryptocurrency_params)

    if result.success?
      render json: result.data.to_h
    else
      render_not_found(result.errors)
    end
  end

  def destroy
    Cryptocurrencies::DestroyService.call(params[:id])
    head :no_content
  end

  private

  def cryptocurrency_params
    params.permit(PERMITTED_PARAMS).to_h.symbolize_keys
  end
end
