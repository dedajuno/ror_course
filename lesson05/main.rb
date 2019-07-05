require_relative 'instancecounter'
require_relative 'module'
require_relative 'route'
require_relative 'train'
require_relative 'station'
require_relative 'passenger'
require_relative 'cargo'
require_relative 'passengerwagon'
require_relative 'cargowagon'
require_relative 'wagon'

train1 = Train.new(1,'Cargo')
train1.company_name = 'Gavno'

puts train1.company_name

station1 = Station.new('MSK')
station2 = Station.new('SPB')
cargotrain = CargoTrain.new(5, 'Cargo')
cargotrain2 = CargoTrain.new(6, 'Cargo')

puts Station.all
puts Train.find(1)
puts Train.find(2)

puts Station.instances
puts ''
puts Train.instances
puts ''
puts CargoTrain.instances

