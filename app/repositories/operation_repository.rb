# frozen_string_literal: true

class OperationRepository
  class << self
    def all
      @list ||= []
    end

    def find(id)
      all.find { |o| o.id == id.to_i }
    end

    def save(operation)
      all << operation
      operation
    end

    def next_id
      @next_id ||= 1
      id = @next_id
      @next_id += 1
      id
    end
  end
end
