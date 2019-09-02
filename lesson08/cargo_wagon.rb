# frozen_string_literal: true

require_relative 'wagon'
class CargoWagon < Wagon
  attr_accessor :filled_capacity, :capacity

  def initialize(name, capacity)
    @name = name
    @type = 'Cargo'
    @capacity = capacity
    @filled_capacity = 0
  end

  def free_capacity
    capacity - filled_capacity
  end

  def fill_capacity(volume)
    @filled_capacity += volume if free_capacity.positive?
  end
end

# c = CargoWagon.new(20)
# c.fill_capacity(1)
# puts c.free_capacity
# puts c.filled_capacity
