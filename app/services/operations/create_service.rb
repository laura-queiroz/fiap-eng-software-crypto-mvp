# frozen_string_literal: true

module Operations
  class CreateService
    def self.call(attributes)
      new.call(attributes)
    end

    def call(attributes)
      attrs = attributes.to_h.symbolize_keys
      cryptocurrency_id = attrs[:cryptocurrency_id].to_i
      crypto = CryptocurrencyRepository.find(cryptocurrency_id)

      unless crypto
        return ServiceResult.failure(errors: "Cryptocurrency not found", error_code: :cryptocurrency_not_found)
      end

      op_attrs = {
        cryptocurrency_id: cryptocurrency_id,
        operation_type: attrs[:operation_type],
        amount: attrs[:amount].to_f,
        cryptocurrency_price: crypto.price,
        operation_date: Time.now
      }
      op = Operation.new(op_attrs)

      unless op.valid?
        return ServiceResult.failure(errors: op.errors, error_code: :validation_failed)
      end

      op.id = OperationRepository.next_id
      OperationRepository.save(op)
      ServiceResult.success(op)
    end
  end
end
