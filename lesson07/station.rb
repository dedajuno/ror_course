class Station
  include InstanceCounter

  attr_reader :name, :trains

  @@all = []

  def initialize(name)
    @name = name
    validate!
    @trains = []
    @@all << self
    register_instance
  end

  def list
    @trains.each {|train| puts "#{train.number}: #{train.type}"}
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  def validate!
    raise "Station name can't be nil." if name.nil? || name.empty?
#    raise "Station name cant' be the same" if @stations_names.each {|station_name| station_name } == name
  end

  def receive(train)
    @trains << train
  end

  def send(train)
    raise "Train #{train} not found" if !@trains.include?(train)
#    if @trains.include?(train)
      @trains.delete(train)
#    else
#      puts "#{train} not found"
#    end
  end

  def self.all
    @@all
  end

  def list_trains
    @trains.each {|train| yield(train) }
  end
end
