class Train
  attr_reader :type
  attr_accessor :carriages, :current_station, :number

  @@trains = {}

  def initialize(number, type)
    @speed = 0
    @number = number
    @type = type
    @carriages = []
    @index_station = 0
    @@trains[number] = self
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
    @current_station = @route.stations.first
    @index_station = 0
    #@current_station.receive(self)
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
    if @index_station == 0
      puts "We are already on the first station"
    else
      @index_station -= 1
    end
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

  def self.find(number)
    print "smthnk"
    print "#{@@trains[number]}"
  end
end

train1 = Train.new(1, "Cargo")
train2 = Train.new(2, "Cargo")

puts train1.find(1)

