require_relative 'wagon'
class PassengerWagon < Wagon
  attr_accessor :seats, :occupied_seats
  def initialize (seats)
    @type = 'Passenger'
    @seats = seats
    @occupied_seats = 0
  end

  def occupy_seat
    if free_seats > 0
      @occupied_seats += 1
    end
  end

  def free_seats
    seats - occupied_seats
  end
end

p = PassengerWagon.new(20)
p.occupy_seat
p.occupy_seat
puts "#{p.occupied_seats}"
puts "#{p.free_seats}"