#!/usr/bin/env ruby

require_relative 'instance_counter'
require_relative 'validation'
require_relative 'accessors'

class Route
  include InstanceCounter
  include Validation
  extend Accessors

  attr_reader :stations

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
