# frozen_string_literal: true

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

private

@trains = []
@routes = []
@stations = []
@carriages = []

def create_station
  puts 'Enter station name: '
  station_name = gets.chomp
  station = Station.new(station_name)
  @stations << station
rescue RuntimeError => e
  puts e.message
  retry
end

def create_train
  puts 'Set number of train (e.g. 123-as, a3a-12 or 1s23l)'
  number = gets.chomp
  puts 'Choose train type Passenger(P) or Cargo(C): '
  type = gets.chomp
  @trains << CargoTrain.new(number, 'Cargo') if type =~ /[c]/i
  @trains << PassengerTrain.new(number, 'Passenger') if type =~ /[p]/i
rescue RuntimeError => e
  puts e.message
  retry
end

def create_route
  puts 'Choose the FIRST station of route: '
  first_station = choose_station
  puts 'Enter the NEXT station of route: '
  last_station = choose_station
  @routes << Route.new(first_station, last_station)
rescue RuntimeError => e
  puts e.message
  retry
end

def choose_route
  list_routes
  print 'Choose the route number: '
  route_prompt = gets.chomp.to_i
  raise 'Route number should be a digit' if route_prompt =~ /[\d]+/
  raise 'No route exists' unless @routes.include?(@routes[route_prompt - 1])

  @routes[route_prompt - 1]
end

def choose_station
  @stations.empty? || @stations.size <= 1 ? create_station : list_stations
  station_prompt = gets.chomp.to_i
  raise 'Station number should be a digit' if station_prompt =~ /[\d]/

  @stations[station_prompt - 1]
end

def add_station_to_route
  route = choose_route
  create_station if @stations.size <= 2
  station = choose_station
  route.add(station)
rescue RuntimeError => e
  puts e.message
  retry
end

def delete_station_from_route
  route = choose_route
  puts 'Choose station, which should be deleted: '
  station = choose_station
  raise 'There is only 2 stations persist in route' if route.stations.size <= 2

  route.del(station)
  puts "Successfully deleted #{station.name} from #{route}"
rescue RuntimeError => e
  puts e.message
  retry
end

def choose_train
  list_trains
  print 'Choose the train number: '
  train_prompt = gets.chomp.to_i
  @trains[train_prompt - 1]
end

def assign_route_to_train
  puts 'Assign route to train.'
  train = choose_train
  route = choose_route

  train.route(route)
  train.current_station.receive(train)
  puts "Current station for train #{train} is #{train.current_station.name}"
end

def create_carriage(train)
  puts 'Specify carriage name and capacity: '
  name = gets.chomp
  volume = gets.to_i
  carriage = if train.class == CargoTrain
               CargoWagon.new(name, volume)
             else
               PassengerWagon.new(name, volume)
             end
  # @carriages << carriage
end

def add_carriage(train)
  carriage = create_carriage(train)
  train.add_carriage(carriage)
   @carriages << carriage
end

def delete_carriage(train)
  carriage = list_carriages_for_train
  train.remove_carriage(carriage)
end

def change_carriages_count
  train = choose_train
  puts 'Delete(d) or add(a): '
  option = gets.chomp
  raise 'You can only add(a) or delete(d)' if option !~ /[da]/i

  add_carriage(train) if option == 'a'
  delete_carriage(train) if option == 'd'
rescue RuntimeError => e
  puts e.message
  retry
end

def move_forward
  train = choose_train
  train.move_forward
  puts "Current station of chosen train is #{train.current_station}"
end

def move_backward
  train = choose_train
  train.move_back
  puts "Current station of chosen train is #{train.current_station}"
end

def move_train
  print "Specify which direction should train move (e.g. 'back' or 'fwd'): "
  direction = gets.chomp
  move_backward if direction == 'back'
  move_forward if direction == 'fwd'
rescue RuntimeError => e
  puts e.message
  retry
end

def list_stations
  return puts 'No stations created yet.' if @stations.empty?

  @stations.each_with_index do |station, index|
    puts "##{index + 1} --- #{station.name}"
  end
end

def list_routes
  return puts 'No routes created yet.' if @routes.empty?

  @routes.each_with_index do |route, number|
    puts "#{number + 1} --- #{route} with following stations: #{route.stations}"
  end
end

def list_trains
  return puts 'No trains created yet.' if @trains.empty?

  @trains.each_with_index do |train, number|
    puts "#{number + 1} --- #{train.number} #{train.type} #{train.carriages}"
  end
end

def list_carriages_for_train
  return puts 'No trains created yet.' if @carriages.empty?

  train = choose_train
  train.list_carriages do |carriage|
    puts carriage
  end
end

def list_trains_on_station
  return puts 'No stations created yet.' if @stations.empty?

  station = choose_station
  station.list_trains do |trains|
    puts "#{trains.type} train with number: #{trains.number}"
  end
end

def fill_passenger_carriage(train)
  train.list_carriages do |carriage|
    puts "From whole #{carriage.seats} seats #{carriage.occupied_seats} is occupied."
    puts 'Please set the number of seats you want to occupy: '
    carriage.occupy_seat
  end
end

def fill_cargo_carriage(train)
  train.list_carriages do |carriage|
    puts 'Please set the volume you want to fill: '
    volume = gets.to_i
    carriage.fill_capacity(volume)
    puts "From whole #{carriage.capacity} capacity, #{carriage.filled_capacity} is filled."
  end
end

def fill_carriage
  return puts 'No carriages available' if @carriages.empty? || @trains.empty?

  train = choose_train
  fill_passenger_carriage(train) if train.class == PassengerTrain
  fill_cargo_carriage(train) if train.class == CargoTrain
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
Fill carriages                  14
Press Enter to quit.
> "
print prompt
while option = gets.to_i
  if option == 1
    create_station
    puts '__________________'
    print prompt
  elsif option == 2
    create_train
    puts '__________________'
    print prompt
  elsif option == 3
    create_route
    puts '__________________'
    print prompt
  elsif option == 4
    if @routes.empty?
      puts 'No routes were created.'
      create_route
    end
    add_station_to_route
    puts '__________________'
    print prompt
  elsif option == 5
    delete_station_from_route
    puts '__________________'
    print prompt
  elsif option == 6
    assign_route_to_train
    puts '__________________'
    print prompt
  elsif option == 7
    change_carriages_count
    puts '__________________'
    print prompt
  elsif option == 8
    move_train
    puts '__________________'
    print prompt
  elsif option == 9
    list_stations
    puts '__________________'
    print prompt
  elsif option == 10
    list_routes
    puts '__________________'
    print prompt
  elsif option == 11
    list_trains
    puts '__________________'
    print prompt
  elsif option == 12
    list_carriages_for_train
    puts '__________________'
    print prompt
  elsif option == 13
    list_trains_on_station
    puts '__________________'
    print prompt
  elsif option == 14
    fill_carriage
    puts '__________________'
    print prompt
  else
    puts 'GL HF'
    break
  end
end
