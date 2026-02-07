# frozen_string_literal: true

Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  root to: redirect("/cryptocurrencies")

  resources :cryptocurrencies, only: %i[index show new create update destroy]
  resources :operations, only: %i[index show new create]
end
