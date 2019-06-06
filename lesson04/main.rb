=begin
Задание:

Разбить программу на отдельные классы (каждый класс в отдельном файле)
Разделить поезда на два типа PassengerTrain и CargoTrain, сделать родителя для классов, который будет содержать общие методы и свойства
Определить, какие методы могут быть помещены в private/protected и вынести их в такую секцию. В комментарии к методу обосновать, почему он был вынесен в private/protected
Вагоны теперь делятся на грузовые и пассажирские (отдельные классы). К пассажирскому поезду можно прицепить только пассажирские, к грузовому - грузовые.
При добавлении вагона к поезду, объект вагона должен передаваться как аргумент метода и сохраняться во внутреннем массиве поезда, в отличие от предыдущего задания, где мы считали только кол-во вагонов.
Параметр конструктора "кол-во вагонов" при этом можно удалить.

  Добавить текстовый интерфейс:
Создать программу в файле main.rb, которая будет позволять пользователю через текстовый интерфейс делать следующее:
- Создавать станции
- Создавать поезда
- Создавать маршруты и управлять станциями в нем (добавлять, удалять)
- Назначать маршрут поезду
- Добавлять вагоны к поезду
- Отцеплять вагоны от поезда
- Перемещать поезд по маршруту вперед и назад
- Просматривать список станций и список поездов на станции

=end
require_relative 'route'
require_relative 'train'
require_relative 'station'
require_relative 'passenger'
require_relative 'cargo'
require_relative 'passengerwagon'
require_relative 'cargowagon'
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
  @stations.each {|station| puts "Station: #{station.name}"}
  puts "Done"
end


def create_train
  number = 0
  loop do
    print "Choose train type (Passenger(P) or Cargo(C): "
    type = gets.chomp
    number += 1
    #print "Enter initial carriage count: "
    #carriage_count = gets.to_i
    (type == "C") ?
      train = CargoTrain.new(number, "Cargo") :
      train = PassengerTrain.new(number, "Passenger")
    @trains << train
    print "Add new train? (y/n): "
    add_more = gets.chomp
    if add_more == "n"
      break
    end
  end
  @trains.each {|train| puts "Train ##{train.number} | Type: #{train.type} | Carriages: #{train.carriages}" }
  #@trains.each_with_index {|train| puts "#{train}"}
  puts "Done"
end

def create_route
  print "Enter the first station of route: "
  first_station = gets.chomp
  print "Enter the next station of route: "
  last_station = gets.chomp
  route = Route.new(first_station, last_station)
  @routes << route
  loop do
    print "Add another station? (y/n): "
    add_more = gets.chomp
    if add_more == "y"
      add_station_to_route
    else
      break
    end
  end
  puts "Done for create_route"
end

def add_station_to_route
  @routes.each_with_index { |name, number | puts "#{number + 1} --- #{name}"}
  print "Choose the route number: "
  route = gets.to_i
  puts "Enter station, which should be added: "
  added_station = gets.chomp
  @routes[route - 1].add(added_station)
  puts "#{@routes[route - 1].list}"
end

def delete_station_from_route
  @routes.each_with_index { |name, number | puts "#{number + 1} --- #{name}"}
  print "Choose the route number: "
  route = gets.to_i
  puts "Enter station, which should be deleted: "
  deleted_station = gets.chomp
  @routes[route - 1].del(deleted_station)
  puts "#{@routes[route - 1].list}"
end

def assign_route_to_train
  puts "Assign route to train."
  puts "Choose train number: "
  @trains.each_with_index {|name, number| puts "##{number + 1} - #{name}"}
  train_number = gets.to_i
  until @trains.include?(@trains[train_number - 1])
    puts "There is no any train with this number."
    create_train
    break
  end
  puts "Choose route: "
  @routes.each_with_index {|name, number| puts "#{number + 1} - #{name}"}
  route_number = gets.to_i
  until @routes.include?(@routes[route_number - 1])
    puts "There is no any route with this number"
    create_route
    break
  end
  @trains[train_number - 1].route(@routes[route_number - 1])
  puts "Current station for train #{@trains[train_number - 1]} is #{@trains[train_number - 1].current_station}"
  puts "Done"
end

def change_carriages_count
  puts "Choose train number: "
  @trains.each_with_index {|name, number| puts "##{number + 1} - #{name}"}
  train = gets.to_i
  until @trains.include?(@trains[train - 1])
    puts "There is no such number of train."
    create_train
    break
  end
  puts "Please choose action."
  puts "Delete(d) or add(a): "
  option = gets.chomp
  puts "Specify carriage name: "
  car_value = gets.chomp
  if @trains[train - 1].class == CargoTrain
    CargoWagon.new(car_value)
  else
    PassengerWagon.new(car_value)
  end
  if option == "a"
    @trains[train - 1].add_carriage(car_value)
  else option == "d"
    @trains[train - 1].remove_carriage(car_value)
  end
  @trains.each {|train| puts "Train ##{train.number} | Type: #{train.type} | Carriages: #{train.carriages}"}
end

def move_train
  print "Please choose train number: "
  @trains.each_with_index {|name, number| puts "##{number + 1} - #{name}"}
  train_number = gets.to_i
  #train_index = train_number - 1
  print "Specify which direction should train move (e.g. 'back' or 'fwd': "
  direction = gets.chomp
  if direction == "back"
    @trains[train_number - 1].move_back
    puts "#{@trains[train_number - 1].current_station}"
  elsif direction == "fwd"
    @trains[train_number - 1].move_forward
    puts "#{@trains[train_number - 1].current_station}"
  end
end

def list_stations
  @stations.each {|station| puts "#{station.name} #{station.trains}"}
  puts @stations
end

def list_routes
  @routes.each {|route| puts "#{route.first_station} #{route.last_station}"}
  puts @routes
end

def list_trains
  @trains.each {|train| puts "##{train.number} - #{train.type} #{train.carriage_count}"}
  puts @trains
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
  else
    puts "GL HF"
    break
  end
end

