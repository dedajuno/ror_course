require_relative 'train'
class CargoTrain < Train
  def add_carriage(carriage)
    raise "Wrong carriage type" if type != "Cargo"
    super
  end
end
