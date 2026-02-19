# frozen_string_literal: true

module Cryptocurrencies
  class DestroyService
    def self.call(id)
      new.call(id)
    end

    def call(id)
      CryptocurrencyRepository.delete_by_id(id)
      ServiceResult.success(nil)
    end
  end
end
