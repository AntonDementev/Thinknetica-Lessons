#!/usr/bin/env ruby

require_relative 'company'
require_relative 'instance_counter'

class Train
  attr_reader :number, :station, :waggons, :speed
  attr_accessor :route
  
  include Company
  include InstanceCounter
  
  NUMBER_FORMAT = /^[0-9a-z]{3}-?[0-9a-z]{2}$/i
  
  @@trains = {}
  
  def initialize(number)
    @number = number
    @waggons = []
    @speed = 0
    validate!
    
    register_instance
    @@trains[number] = self
  end
  
  def action_with_waggons(block)
    @waggons.each do |waggon|
      block.call(waggon) 
    end
  end
  
  
  def valid?
    validate!
  rescue
    false
  end
  
  def self.find(number)
    @@trains[number]
  end

  def change_speed(speed)
    @speed = speed
  end

  def stop
    @speed = 0
  end

  def waggons_amount
    @waggons.size
  end
  
  def go_from_station
    if @station
      @station.trains_list.delete(self)
      @station = nil
    end
  end
  
  def go_to_station(station)
    if @station
      self.go_from_station
    end
    station.trains_list << self
    @station = station 
  end
  
  def goto_next_station
    if @route
      if @station.nil?        
        @route.stations[0].take_train(self)
      else
        station_index = @route.stations.index(@station)
      
        if station_index.nil?
          @station.send_train(self)
          @route.stations[0].take_train(self)
        elsif station_index < @route.stations.size - 1
          @route.stations[station_index].send_train(self)
          @route.stations[station_index+1].take_train(self)
        end
      end
    end
  end


  def show_current_station
    if @route
      station_index = @route.stations.index(@station)
      if station_index.nil?
        puts "Поезд №#{@number} сейчас не на маршруте"
      else
        puts "Поезд №#{@number}. Текущая станция: #{@station.name}"
      end
    end  
  end

  def show_next_station
    if @route
      station_index = @route.stations.index(@station)
      case station_index
        when nil
          puts "Поезд №#{@number} сейчас не на маршруте"
        when @route.stations.size - 1
          puts "Поезд №#{@number} уже на конечной станции"
        else
          puts "Поезд №#{@number}. Следующая станция: #{@route.stations[station_index+1].name}"
      end
    end
  end
  
  def show_previous_station
    if @route
      station_index = @route.stations.index(@station)
      case station_index
        when nil
          puts "Поезд №#{@number} сейчас не на маршруте"
        when 0
          puts "Поезд №#{@number} пока ещё на начальной станции"
        else
          puts "Поезд №#{@number}. Предыдущая станция: #{@route.stations[station_index-1].name}"
      end
    end
  end

  def remove_waggon
    if stopped? && @waggons.size > 0
      @waggons.pop
    end
    waggons_amount
  end
  
  def add_waggon(wagon)
    if stopped?
      if check_waggon(wagon)
        @waggons << wagon
      end
    end
    waggons_amount
  end 
  
  protected
  
  def validate!
    raise "Номер поезда не задан" if @number.nil?
    raise "Тип поезда не определён" if self.class != CargoTrain && self.class != PassengerTrain
    raise "Номер поезда неправильного формата" if @number !~ NUMBER_FORMAT
    true
  end
  
  private
  def stopped?
    @speed == 0
  end
  
end

