class CargoTrain < Train
  def add_carriage(carriage)
    return puts "Wrong carriage type" if type != "Cargo"
    super
  end
end
