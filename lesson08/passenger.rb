# frozen_string_literal: true

class PassengerTrain < Train
  def add_carriage(carriage)
    return puts 'Wrong carriage type' if carriage.class != PassengerWagon

    super
  end
end
