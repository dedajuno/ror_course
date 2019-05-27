class CargoTrain < Train
  def change_count(type, value)
    if type == 'Cargo'
      super
    else
      puts "Wrong carriage type"
    end
  end
end
