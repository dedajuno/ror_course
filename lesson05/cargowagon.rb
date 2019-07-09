class CargoWagon < Wagon
  def initialize (name)
    @type = 'Cargo'
    validate!
  end
end