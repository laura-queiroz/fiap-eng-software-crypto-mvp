# frozen_string_literal: true

class CryptocurrenciesController < ApplicationController
  def index
    list = Repositories::InMemoryStore.cryptocurrencies.map(&:to_h)
    @cryptocurrencies = list
    respond_to do |format|
      format.json { render json: list }
      format.html { render :index, layout: "application" }
    end
  end

  def show
    crypto = Repositories::InMemoryStore.find_cryptocurrency(params[:id])
    if crypto
      respond_to do |format|
        format.json { render json: crypto.to_h }
        format.html { render plain: crypto.to_h.inspect }
      end
    else
      respond_to do |format|
        format.json { render json: { error: "Not found" }, status: :not_found }
        format.html { render plain: "Not found", status: :not_found }
      end
    end
  end

  def new
    render :new, layout: "application"
  end

  def create
    attrs = params.permit(:name, :symbol, :price, :image).to_h.symbolize_keys
    attrs[:price] = attrs[:price].to_f if attrs[:price]
    crypto = Cryptocurrency.new(attrs)
    unless crypto.valid?
      respond_to do |format|
        format.json { render json: { errors: "name, symbol and price are required" }, status: :unprocessable_entity }
        format.html { render :new, layout: "application", status: :unprocessable_entity }
      end
      return
    end
    crypto.id = Repositories::InMemoryStore.next_cryptocurrency_id
    Repositories::InMemoryStore.cryptocurrencies << crypto
    respond_to do |format|
      format.json { render json: crypto.to_h, status: :created }
      format.html { redirect_to cryptocurrencies_path, status: :see_other }
    end
  end

  def update
    crypto = Repositories::InMemoryStore.find_cryptocurrency(params[:id])
    unless crypto
      render json: { error: "Not found" }, status: :not_found
      return
    end
    attrs = params.permit(:name, :symbol, :price, :image).to_h.symbolize_keys
    attrs[:price] = attrs[:price].to_f if attrs[:price]
    crypto.name = attrs[:name] if attrs.key?(:name)
    crypto.symbol = attrs[:symbol] if attrs.key?(:symbol)
    crypto.price = attrs[:price] if attrs.key?(:price)
    crypto.image = attrs[:image] if attrs.key?(:image)
    render json: crypto.to_h
  end

  def destroy
    list = Repositories::InMemoryStore.cryptocurrencies
    list.delete_if { |c| c.id == params[:id].to_i }
    head :no_content
  end
end
