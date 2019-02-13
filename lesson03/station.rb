class Station
  attr_reader :name,
              :list_of_trains

  def initialize(name)
    @name = name
    @list_of_trains = []
  end
  
  def Station.receive(train)
#    @train = train
    @list_of_trains << train
  end
  
  def Station.list
    #@list_of_trains
    #puts @list_of_trains
    @list_of_trains.each {|station| puts station}
  end

#  def Station.list_by_type(type)
#    @type = Train.type
#    if type = freight
      


  def Station.send(train)
   if @list_of_trains.include?(train)
     @list_of_trains.delete(train)
     puts @list_of_trains
   else
     puts "#{train} not found"
   end
  end
end

class Route
  attr_reader :station

  def initialize(first_station, last_station)
    @first_station = first_station
    @last_station = last_station
    @list_of_stations = [first_station, last_station]
  end

  def Route.add_station(station)
    @list_of_stations.insert(1,station)
  end
  
  def Route.del_station(station)
    if station != @first_station && station != @last_station
      @list_of_stations.delete(station)
    else
      puts "Not allowed"
    end
  end

  def Route.list
    puts @list_of_stations
  end
end

class Train
  def initialize(number, type, vagon_count)
    @number = number
    @type = [passenger, freight]
    @vagon_count = vagon_count
  end

  def Train.accellerate(speed)
    @speed = speed
  end

  def Train.current_speed
    @speed
    puts @speed
  end
  
  def Train.stop
    speed = 0
    @speed = speed
  end

  def Train.vagons
    @vagon_count
    puts @vagon_count
  end

  def Train.add_del_vagons(value)
    if Train.current_speed = 0
      if value > 0
        @vagon_count += 1
      else
        @vagon_count -= 1
      end
    end
  end
  
  def Train.route(route)
    @route = Route.list
    puts @route
    @first_station = Route.first_station

  end

  def Train.move_forward(station)
    @station = Route.list
  end
end
    


