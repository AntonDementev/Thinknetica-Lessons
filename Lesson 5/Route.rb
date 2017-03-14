#!/usr/bin/env ruby

require_relative 'InstanceCounter'

class Route 
  attr_reader :stations
  
  include InstanceCounter
  self.begin_count
  
  def initialize(begin_station, end_station)
    @stations = [begin_station, end_station]
    register_instance
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
end
