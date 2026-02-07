# frozen_string_literal: true

class Operation
  attr_accessor :id, :cryptocurrency_id, :operation_type, :amount, :cryptocurrency_price, :cost, :operation_date

  def initialize(attrs = {})
    @id = attrs[:id]
    @cryptocurrency_id = attrs[:cryptocurrency_id]
    @operation_type = attrs[:operation_type].to_s.downcase
    @amount = attrs[:amount].to_f
    @cryptocurrency_price = attrs[:cryptocurrency_price].to_f
    @cost = attrs[:cost]
    @cost = amount * cryptocurrency_price if @cost.nil? && amount && cryptocurrency_price
    @operation_date = attrs[:operation_date] || Time.now
  end

  def to_h
    {
      id: id,
      cryptocurrency_id: cryptocurrency_id,
      operation_type: operation_type,
      amount: amount,
      cryptocurrency_price: cryptocurrency_price,
      cost: cost,
      operation_date: operation_date.is_a?(Time) ? operation_date.iso8601 : operation_date
    }
  end

  def valid?
    return false if cryptocurrency_id.to_i <= 0
    return false unless %w[buy sell].include?(operation_type.to_s)
    return false unless amount.is_a?(Numeric) && amount > 0

    true
  end
end
