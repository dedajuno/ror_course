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

@trains = []
@routes = []
@stations = []

def create_station
  print "Enter station name: "
  station_name = gets.chomp
  station = Station.new(station_name)
  @stations << station
  puts "Done"
end

def create_train
  print "Choose train type (Passenger or Cargo): "
  type = gets.chomp
  print "Enter train number: "
  number = gets.to_i
  print "Enter initial carriage count: "
  carriage_count = gets.to_i
  (type == "Cargo") ?
      train = CargoTrain.new(number, type, carriage_count) :
      train = PassengerTrain.new(number, type, carriage_count)
  @trains << train
  puts "Done"
end

def create_route
  print "Enter the first station of route: "
  first_station = gets.chomp
  print "Enter the next station of route: "
  last_station = gets.chomp
  route = Route.new(first_station, last_station)
  @routes << route
  puts "Done"
end

def delete_station_from_route
  puts "Enter station, which should be deleted: "
  deleted_station = gets.chomp
  @routes[route].del(deleted_station)
  puts "Done"
end

def add_station_to_route
  puts "Enter station, which should be added: "
  added_station = gets.chomp
  @routes[route].add(added_station)
  puts "Done"
end

def assign_route_to_train
  puts "Assign route to train."
  puts "Choose train number: "
  #train = @trains
  @trains.each_with_index {|name, number| puts "##{number + 1} - #{name}"}
  train_number = gets.to_i
  until @trains.include?(train_number - 1) do
    #train_name = gets.chomp
    break
  end
  puts "Choose route: "
  @routes.each_with_index {|name, number| puts "#{number + 1} - #{name}"}
  route_number = gets.to_i
  until @routes.include?(route_number - 1)
    #route_name = gets.chomp
    break
  end
  @trains[train_number - 1].route(@routes[route_number - 1])
  puts "Done"
end

def change_carriages_count
  puts "Choose train: "
  @trains.each_with_index {|name, number| puts "##{number + 1} - #{name}"}
  train = gets.to_i
  return change_carriages_count until @trains.include?(train)
  puts "Specify count of carriages to add(+1) or delete(-1): "
  car_value = gets.to_i
  if car_value > 0
    Train.carriage_count += car_value
  else
    @carriage_count -= car_value
  end
  puts "Done"
end

def move_train
  print "Please choose train number: "
  @trains.each_with_index {|name, number| puts "##{number + 1} - #{name}"}
  train_number = gets.to_i
  train_index = train_number - 1
  print "Specify which direction should train move (e.g. 'back' or 'fwd': "
  direction = gets.chomp
  if direction == "back"
    @trains[train_index].move_back
    puts "#{Train.current_station}"
  elsif direction == "fwd"
    @trains[train_index].move_forward
    puts "#{Train.current_station}"
  end
end

def list_stations
  @stations.each_with_index {|name, number| puts "##{number + 1} - #{name}"}
end

prompt = "Please choose number of option below:
Create new station              1
Create new train                2
Create new route                3
Add station from route          4
Delete station from route       5
Assign route to train           6
Change count of carriages       7
Move train backward or forward  8
List stations                   9
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
    add_station_to_route
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
  else
    puts "GL HF"
    break
  end
end

