#!/usr/bin/env ruby

require_relative 'instance_counter'
require_relative 'validation'
require_relative 'accessors'

class Station
  include InstanceCounter
  include Validation
  extend Accessors

  attr_reader :trains_list
  attr_accessor_with_history :name
  validate :name, :presence
  validate :name, :type, String

  @@stations_list = []

  def initialize(name)
    @name = name
    @trains_list = []
    register_instance
    @@stations_list << self
  end

  def self.all
    @@stations_list
  end

  def action_with_trains(block)
    @trains_list.each do |train|
      block.call(train)
    end
  end

  def take_train(train)
    train.go_to_station(self)
  end

  def show_trains
    puts "Список поездов на станции #{@name}:"
    @trains_list.each do |train|
      puts "* #{train.number}"
    end
  end

  def show_trains_with_type(type)
    trains_this_type = @trains_list.select { |train| train.type == type }

    print 'Грузовые поезда ' if type == :cargo
    print 'Пассажирские поезда ' if type == :passenger
    puts "(#{trains_this_type.size} шт.):"

    trains_this_type.each { |train| puts "* Поезд №#{train.number}" }
  end

  def send_train(train)
    train.go_from_station
  end
end
