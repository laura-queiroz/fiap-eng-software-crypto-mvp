# frozen_string_literal: true

module Repositories
  class InMemoryStore
    class << self
      def cryptocurrencies
        @cryptocurrencies ||= []
      end

      def operations
        @operations ||= []
      end

      def next_cryptocurrency_id
        @next_cryptocurrency_id ||= 1
        id = @next_cryptocurrency_id
        @next_cryptocurrency_id += 1
        id
      end

      def next_operation_id
        @next_operation_id ||= 1
        id = @next_operation_id
        @next_operation_id += 1
        id
      end

      def find_cryptocurrency(id)
        cryptocurrencies.find { |c| c.id == id.to_i }
      end

      def find_operation(id)
        operations.find { |o| o.id == id.to_i }
      end
    end
  end
end
