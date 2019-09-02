# frozen_string_literal: true

class Route
  include InstanceCounter

  attr_reader :stations

  def initialize(first_station, last_station)
    @stations = [first_station, last_station]
    validate!
    register_instance
  end

  def add(station)
    @stations.insert(-2, station)
  end

  def del(station)
    @stations.delete(station)
  end

  def list
    puts @stations
  end

  def valid?
    validate!
  rescue RuntimeError => e
    puts e.message
    false
  end

  protected

  def validate!
    raise "First station name couldn't be empty or nil" if @stations.first.nil?
    raise "Last station name couldn't be empty or nil" if @stations.last.nil?
    raise "First and last station names couldn't be the same" if @stations.first == @stations.last
  end
end
