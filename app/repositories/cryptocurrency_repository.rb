# frozen_string_literal: true

class CryptocurrencyRepository
  class << self
    def all
      @list ||= []
    end

    def find(id)
      all.find { |c| c.id == id.to_i }
    end

    def save(cryptocurrency)
      all << cryptocurrency
      cryptocurrency
    end

    def next_id
      @next_id ||= 1
      id = @next_id
      @next_id += 1
      id
    end

    def delete_by_id(id)
      all.delete_if { |c| c.id == id.to_i }
    end
  end
end
