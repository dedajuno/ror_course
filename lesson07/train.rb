require_relative 'instance_counter'
require_relative 'company.rb'

class Train
  include Company
  include InstanceCounter

 # TRAIN_NUMBER = /^[\w]{3}-?[\w]{2}$/

  attr_accessor :carriages, :current_station, :number, :type

  @@trains = {}

  def initialize(number, type)
    @speed = 0
    @index_station = 0
    @number = number
    @type = type
 #   validate!
    @carriages = []
    @@trains[number] = self
#    register_instance
  end

  def accellerate(speed)
    @speed += speed
  end

  def current_speed
    @speed
  end

  def stop
    speed = 0
    @speed = speed
  end

  def route(route)
    @route = route
    @route.stations.first.receive(self)
    @index_station = 0
  end

  def next_station
    @route.stations[@index_station + 1]
  end

  def current_station
    @route.stations[@index_station]
  end

  def previous_station
    @route.stations[@index_station - 1]
  end

  def move_forward
    if @index_station >= @route.stations.size - 1
      puts "Dead End!"
    else
      @index_station += 1
    end
  end

  def move_back
    @index_station -= 1
    raise "We are already on the first station." if @index_station == 0
  end

  def add_carriage(carriage)
    if current_speed == 0
      @carriages << carriage
    else
      puts "Train is moving. First stop the train"
    end
  end

  def remove_carriage(carriage)
    if current_speed == 0
      if @carriages.empty? || @carriages.include?(carriage) != true
        puts "There is no any or given carriages added to train."
      else
        @carriages.delete(carriage)
      end
    else
      puts "Train is moving. First stop the train"
    end
  end

  def valid?
    validate!
  rescue
    false
  end

  def list_carriages
    @carriages.each { |carriage| yield (carriage) }
  end

  protected

  def validate!
    raise "Train number is invalid and should contain at least 5 symbols (e.g. 12345 or 123-4a)" if number !~ TRAIN_NUMBER
    raise "Train type can't be empty" if type.nil? || type.empty?
  end

  private

  def self.find(number)
    @@trains[number]
  end
end

#t = Train.new(1, "Passenger")
#t.add_carriage("QWE")
#t.list_carriages
