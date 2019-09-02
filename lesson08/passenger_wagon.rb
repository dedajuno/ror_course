# frozen_string_literal: true

require_relative 'wagon'
class PassengerWagon < Wagon
  attr_accessor :seats, :occupied_seats
  def initialize(name, seats)
    @name = name
    @type = 'Passenger'
    @seats = seats
    @occupied_seats = 0
  end

  def occupy_seat
    self.occupied_seats += 1 if free_seats.positive?
  end

  def free_seats
    seats - occupied_seats
  end
end
