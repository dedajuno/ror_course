class CargoTrain < Train
  def change_count(value)
    if value.class == CargoWagon
      super
    else
      puts "Wrong carriage type"
    end
  end
end
