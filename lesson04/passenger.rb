class PassengerTrain < Train
  def change_count(value)
    if value.class == PassengerWagon
      super
    else
      puts "Wrong carriage type"
    end
  end
end
