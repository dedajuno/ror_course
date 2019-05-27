require_relative 'train'
class PassengerTrain < Train
  def change_count(type, value)
    if type == 'Passenger'
      super
    else
      puts "Wrong carriage type"
    end
  end
end
