require_relative 'wagon'
class PassengerWagon < Wagon
  def initialize (name)
    @type = 'Passenger'
  end
end
