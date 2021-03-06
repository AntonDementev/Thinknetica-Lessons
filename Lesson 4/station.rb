#!/usr/bin/env ruby

class Station
  attr_reader :name, :trains_list
  @@list = []
  
  def initialize(name)
    @name = name
    @trains_list = []
    @@list << self
  end
  
  def Station.get_list
    @@list
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
end
