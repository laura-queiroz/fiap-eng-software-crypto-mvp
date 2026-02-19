# frozen_string_literal: true

module Cryptocurrencies
  class UpdateService
    def self.call(id, attributes)
      new.call(id, attributes)
    end

    def call(id, attributes)
      crypto = CryptocurrencyRepository.find(id)
      return ServiceResult.not_found unless crypto

      attrs = attributes.to_h.symbolize_keys
      attrs[:price] = attrs[:price].to_f if attrs.key?(:price)

      crypto.name = attrs[:name] if attrs.key?(:name)
      crypto.symbol = attrs[:symbol] if attrs.key?(:symbol)
      crypto.price = attrs[:price] if attrs.key?(:price)
      crypto.image = attrs[:image] if attrs.key?(:image)

      ServiceResult.success(crypto)
    end
  end
end
