class Station
  attr_reader :name,
              :trains
  @@all = []

  def initialize(name)
    @name = name
    @trains = []
    @@all << name
  end

  def list
    @trains.each {|train| puts "#{train.number}: #{train.type}"}
  end
  private
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

  private
  def self.all
    @@all
  end
end