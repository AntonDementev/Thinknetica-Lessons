#!/usr/bin/env ruby

require_relative 'instance_counter'

class Route 
  attr_reader :stations
  
  include InstanceCounter

  
  def initialize(begin_station, end_station)
    @stations = [begin_station, end_station]
    validate!
    register_instance
  end
  
  def valid?
    validate!
  rescue
    false
  end
  
  def add_station(station)
    @stations.insert(-2, station)
  end
  
  def remove_station(station)
    @stations.delete(station)
  end
  
  def show_stations
    puts "Список станций маршрута:\n#{@stations}"
  end
  
  protected
  
  def validate!
    raise "Неправильно заданы параметры" if !@stations.all? {|station| station.is_a? Station}
    true
  end
  
end
