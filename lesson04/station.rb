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