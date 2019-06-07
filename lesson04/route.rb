class Route
  attr_reader :stations

  def initialize(first_station, last_station)
    #@first_station = first_station
    #@last_station = last_station
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

#route1 = Route.new("MSK", "SPB")
#puts "#{route1.list}"