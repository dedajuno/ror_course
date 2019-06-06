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
    @index_station = 0
    @current_station.receive(self)
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
end



station1 = Station.new('MSK')
station2 = Station.new('SPB')
station3 = Station.new('FRU')
station4 = Station.new('ALA')
station5 = Station.new('BRL')

route = Route.new(station1, station5)

route.add(station2)
route.add(station3)
route.add(station4)

route.stations.each {|station| puts "Station:  #{station.name}"}

train1 = Train.new(1, 'Cargo', 2)

train1.route(route)

train1.move_forward
train1.move_forward

puts "#{train1.previous_station.name}"
puts "#{train1.current_station.name}"
puts "#{train1.next_station.name}"
puts
#route.list
puts train1