# frozen_string_literal: true

class Cryptocurrency
  include Validatable

  attr_accessor :id, :name, :symbol, :price, :image

  def initialize(attrs = {})
    @id = attrs[:id]
    @name = attrs[:name]
    @symbol = attrs[:symbol]
    @price = attrs[:price].to_f
    @image = attrs[:image].to_s
  end

  def to_h
    {
      id: id,
      name: name,
      symbol: symbol,
      price: price,
      image: image
    }
  end

  private

  def validate
    add_error(:name, "can't be blank") if name.to_s.strip.empty?
    add_error(:symbol, "can't be blank") if symbol.to_s.strip.empty?
    unless price.is_a?(Numeric) && price >= 0
      add_error(:price, "must be present and greater than or equal to 0")
    end
  end
end
