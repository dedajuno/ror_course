require_relative 'instance_counter'
require_relative 'company'
require_relative 'route'
require_relative 'train'
require_relative 'station'
require_relative 'passenger'
require_relative 'cargo'
require_relative 'passenger_wagon'
require_relative 'cargo_wagon'
require_relative 'wagon'

private #так как кроме этого класса методы больше нигде не будут использованы.

@trains = []
@routes = []
@stations = []
@carriages = []

def create_station
  loop do
    print "Enter station name: "
    station_name = gets.chomp
    station = Station.new(station_name)
    @stations << station
    print "Add new station? (y/n): "
    add_more = gets.chomp
    if add_more == "n"
      break
    end
  end
  rescue RuntimeError => error
  puts error.message
  retry
end


def create_train
  loop do
    print "Set number of train (e.g. 123-as, a3a-12 or 1s23l)"
    number = gets.chomp
    print "Choose train type (Passenger(P) or Cargo(C): "
    type = gets.chomp
    if type =~ /[c]/i
      train = CargoTrain.new(number, "Cargo")
    elsif type =~ /[p]/i
      train = PassengerTrain.new(number, "Passenger")
    else
      raise "Wrong input, please choose C or P."
    end
    @trains << train
    puts "Train with number: #{train.number} was created"
    print "Add new train? (y/n): "
    add_more = gets.chomp
    if add_more == 'n'
      break
    end
  end
  rescue RuntimeError => error
    puts error.message
    retry
end

def create_route
  print "Enter the FIRST station of route: "
  first_station = gets.chomp
  @stations << Station.new(first_station)
  print "Enter the NEXT station of route: "
  last_station = gets.chomp
  @stations << Station.new(last_station)
  route = Route.new(first_station, last_station)
  @routes << route
  loop do
    print "Add another station to route? (y/n): "
    add_more = gets.chomp
    if add_more =~ /[Yy]/
      add_station_to_route
    else
      break
    end
  end
  puts "Your route was created with following stations: #{route.stations}"
rescue RuntimeError => error
  puts error.message
  retry
end

def add_station_to_route
  list_routes
  print "Choose the route number: "
  route_prompt = gets.chomp
  route = route_prompt.to_i - 1
  raise "Route number should be a digit." if route_prompt !~ /[\d]+/
  raise "There is no route with such kind of number" if !@routes.include?(@routes[route])
  puts "Enter station, which should be added: "
  added_station = gets.chomp
  @stations << Station.new(added_station)
  @routes[route].add(added_station)
rescue RuntimeError => error
  puts error.message
  retry
end

def delete_station_from_route
  if @routes.empty?
    return puts "There is no any route created yet"
    print prompt
  end
  list_routes
  print "Choose the route number or type 'quit' to quit: "
  route_prompt = gets.chomp
  route = route_prompt.to_i - 1
  raise "Route number should be a digit." if route_prompt !~ /[\d]+/
  raise "There is no route with such kind of number" if !@routes.include?(@routes[route])
  puts "#{@routes[route].list}"
  puts "Enter station, which should be deleted: "
  deleted_station = gets.chomp
  raise "You can't delete stations if there is 2 stations persist in route" if @routes[route].stations.size <= 2
  @routes[route].del(deleted_station)
  puts "Successfully deleted #{deleted_station} from #{@routes[route]}"
rescue RuntimeError => error
  puts error.message
  retry until route_prompt =~ /(quit)/i || deleted_station =~ /(quit)/i
end

def assign_route_to_train
  puts "Assign route to train."
  puts "Choose train number: "
  list_trains
  train_number_prompt = gets.chomp
  train_number = train_number_prompt.to_i - 1
  until @trains.include?(@trains[train_number])
    create_train
    break
  end
  puts "Choose route: "
  list_routes
  route_number_prompt = gets.chomp
  route_number = route_number_prompt.to_i
  until @routes.include?(@routes[route_number - 1])
    puts "There is no any route with this number"
    create_route
    break
  end
  @trains[train_number].route(@routes[route_number])
  puts "Current station for train #{@trains[train_number]} is #{@trains[train_number].current_station}"
end

def change_carriages_count
  puts "Choose train number: "
  list_trains
  train = gets.to_i
  until @trains.include?(@trains[train - 1])
    puts "There is no such number of train."
    create_train
    break
  end
  puts "Please choose action."
  puts "Delete(d) or add(a): "
  option = gets.chomp
  raise "You can only add(a) or delete(d)" if option !~ /[da]/i
  puts "Specify carriage seats or capacity: "
  car_value = gets.chomp
  if @trains[train - 1].class == CargoTrain
    CargoWagon.new(car_value)
  else
    PassengerWagon.new(car_value)
  end
  if option == "a"
    @trains[train - 1].add_carriage(car_value)
  elsif option == "d"
    @trains[train - 1].remove_carriage(car_value)
  else
    raise "Please choose (a)dd or (d)elete" if option =~ /[ad]/
  end
  @trains.each {|train| puts "Train ##{train.number} | Type: #{train.type} | Carriages: #{train.carriages}"}
rescue RuntimeError => error
  puts error.message
  retry
end

def move_train
  puts "Please choose train number: "
  list_trains
  train_number_prompt = gets.chomp
  train_number = train_number_prompt.to_i
  raise "You have to choose at least 1 train" if train_number_prompt !~ /\d/
  print "Specify which direction should train move (e.g. 'back' or 'fwd'): "
  direction = gets.chomp
  if direction == "back"
    @trains[train_number - 1].move_back
    puts "Current station of chosen train is #{@trains[train_number - 1].current_station}"
  elsif direction == "fwd"
    @trains[train_number - 1].move_forward
    puts "Current station of chosen train is #{@trains[train_number - 1].current_station}"
  else
    raise "Please select correct direction (back or fwd)." if direction =~ /(back|fwd)/i
  end
rescue RuntimeError => error
  puts error.message
  retry
end

def list_stations
  return puts "No stations created yet. Press 'Enter'..." && create_station if @stations.empty?
  @stations.each_with_index {|station, index| puts "##{index + 1} --- #{station.name}"}
end

def list_routes
  return puts "No routes created yet. Press 'Enter'..." && create_route if @routes.empty?
  @routes.each_with_index { |route, number | puts "#{number + 1} --- #{route} with following stations: #{route.stations}"}
end

def list_trains
  return puts "No trains created yet. Press 'Enter' to create train" && create_train if @trains.empty?
  @trains.each_with_index { |train, number| puts "#{number + 1} --- Train number: #{train.number} - Train type: #{train.type} with carriages: #{train.carriages}"}
end

def list_carriages_for_train
  puts "Please choose the train: "
  list_trains
  train_number_prompt = gets.chomp
  train_number = train_number_prompt.to_i
  puts "#{@trains[train_number - 1].list_carriages}"
end

def list_trains_on_station
  puts "Please choose station: "
  list_stations
  station_name = gets.chomp
  puts "#{@stations[station_name - 1].list_trains}"
end

def occupy_place
  puts "Please choose train:"
  list_trains
  train_number_prompt = gets.chomp
  train_number = train_number_prompt.to_i
end

prompt = "Please choose number of option below:
Create new station              1
Create new train                2
Create new route                3
Add station to route            4
Delete station from route       5
Assign route to train           6
Change count of carriages       7
Move train backward or forward  8
List stations                   9
List routes                     10
List trains                     11
List carriages for a train      12
List trains for a station       13
Press Enter to quit.
> "
print prompt
while option = gets.to_i do
  if option == 1
    create_station
    puts "__________________"
    print prompt
  elsif option == 2
    create_train
    puts "__________________"
    print prompt
  elsif option == 3
    create_route
    puts "__________________"
    print prompt
  elsif option == 4
    if @routes.empty?
      puts "No routes were created."
      create_route
    else
      add_station_to_route
    end
    puts "__________________"
    print prompt
  elsif option == 5
    delete_station_from_route
    puts "__________________"
    print prompt
  elsif option == 6
    assign_route_to_train
    puts "__________________"
    print prompt
  elsif option == 7
    change_carriages_count
    puts "__________________"
    print prompt
  elsif option == 8
    move_train
    puts "__________________"
    print prompt
  elsif option == 9
    list_stations
    puts "__________________"
    print prompt
  elsif option == 10
    list_routes
    puts "__________________"
    print prompt
  elsif option == 11
    list_trains
    puts "__________________"
    print prompt
  elsif option == 12

  else
    puts "GL HF"
    break
  end
end
