#!/usr/bin/env ruby

require_relative 'instance_counter'

class Station
  attr_reader :name, :trains_list
  @@stations_list = []
  
  include InstanceCounter
  
  def initialize(name)
    @name = name
    @trains_list = []
    validate!
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
  
  def valid?
    validate!
  rescue
    false
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
    trains_this_type = @trains_list.select {|train| train.type == type}
     
    print "Грузовые поезда " if type == :cargo
    print "Пассажирские поезда " if type == :passenger
    puts "(#{trains_this_type.size} шт.):"
    
    trains_this_type.each {|train| puts "* Поезд №#{train.number}"} 
  end

  def send_train(train)
      train.go_from_station
  end
  
  protected
  
  def validate!
    raise "Название станции не задано" if @name.nil?
    raise "Название станции пустое" if @name.size == 0
    true
  end
  
end
