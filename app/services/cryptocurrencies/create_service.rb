# frozen_string_literal: true

module Cryptocurrencies
  class CreateService
    def self.call(attributes)
      new.call(attributes)
    end

    def call(attributes)
      attrs = attributes.to_h.symbolize_keys
      attrs[:price] = attrs[:price].to_f if attrs.key?(:price)
      crypto = Cryptocurrency.new(attrs)

      unless crypto.valid?
        return ServiceResult.failure(errors: crypto.errors, error_code: :validation_failed)
      end

      crypto.id = CryptocurrencyRepository.next_id
      CryptocurrencyRepository.save(crypto)
      ServiceResult.success(crypto)
    end
  end
end
