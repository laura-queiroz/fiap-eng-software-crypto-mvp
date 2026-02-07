# frozen_string_literal: true

class Cryptocurrency
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

  def valid?
    name.to_s.strip != "" && symbol.to_s.strip != "" && price.is_a?(Numeric) && price >= 0
  end
end
