class Train
  attr_reader :number, :type
  attr_accessor :carriage_count, :current_station

  def initialize(number, type, carriage_count)
    @speed = 0
    @number = number
    @type = type
    @carriage_count = carriage_count
    @index_station = 0
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

  def change_count(type, value)
    if current_speed == 0
      if value > 0
        @carriage_count += value
      else
        @carriage_count -= value
      end
    else
      puts "Train is moving. First stop the train"
    end
  end
end