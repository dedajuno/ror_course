# frozen_string_literal: true

class PassengerTrain < Train
  def add_carriage(carriage)
    raise 'Wrong carriage type' if type != 'Passenger'

    super
  end
end
