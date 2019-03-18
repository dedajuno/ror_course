class Station
  attr_reader :name,
              :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def list
    @trains.each {|train| puts "#{train.number}: #{train.type}"}
  end

  def receive(train)
    @trains << train
  end

  def send(train)
    if @trains.include?(train)
       @trains.delete(train)
    else
      puts "#{train} not found"
    end
  end
end

class Route
  attr_reader :stations

  def initialize(first_station, last_station)
    @first_station = first_station
    @last_station = last_station
    @stations = [first_station, last_station]
  end

  def add(station)
    @stations.insert(-2,station)
  end

  def del(station)
    if station != @first_station && station != @last_station
      @stations.delete(station)
    else
      puts "Not allowed"
    end
  end

  def list
    puts @stations
  end
end

class Train
  attr_reader :number, :type
  attr_accessor :vagon_count, :current_station

  def initialize(number, type, vagon_count)
    @speed = 0
    @number = number
    @type = type
    @vagon_count = vagon_count
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

  def change_count(value)
    if current_speed == 0
      if value > 0
        @vagon_count += 1
      else
        @vagon_count -= 1
      end
    else
      puts "Train is moving. First stop the train"
    end
  end

  def route(route)
    @route = route
    @current_station = @route.stations.first
    @current_station.receive(self)
  end

  def next_station
    station_index = @route.stations.index(@current_station)
    if station_index >= @route.stations.size - 1
      puts "end of route"
    else
      puts "next station is - #{@route.stations[station_index + 1].name}"
    end
  end

  def previous_station
    station_index = @route.stations.index(@current_station)
    if station_index <= 0
      puts "#{@current_station.name}"
    else
      puts "#{@route.stations[station_index - 1].name}"
    end
  end

  def move_forward
    station_index = @route.stations.index(@current_station)
    if station_index >= @route.stations.size - 1
      puts "Dead End"
    else
      @current_station = @route.stations[station_index + 1]
      @current_station.receive(self)
      puts "#{@current_station.name}"
    end
  end

  def move_back
    station_index = @route.stations.index(@current_station)
    if station_index <= 0
      puts "Start"
    else
      @current_station = @route.stations[station_index - 1]
      @current_station.receive(self)
      puts "#{@current_station.name}"
    end
  end
end
