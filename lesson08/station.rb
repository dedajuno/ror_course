# frozen_string_literal: true

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
    @trains.each { |train| puts "#{train.number}: #{train.type}" }
  end

  def valid?
    validate!
    true
  rescue RuntimeError => e
    puts e.message
    false
  end

  def validate!
    raise "Station name can't be nil." if name.nil? || name.empty?
  end

  def receive(train)
    @trains << train
  end

  def send(train)
    raise "Train #{train} not found" unless @trains.include?(train)

    @trains.delete(train)
  end

  def self.all
    @@all
  end

  def list_trains
    @trains.each { |train| yield(train) }
  end
end
