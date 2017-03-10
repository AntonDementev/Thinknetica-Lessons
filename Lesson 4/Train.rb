#!/usr/bin/env ruby

class Train
  attr_reader :number, :station, :waggons
  attr_accessor :route
  def initialize(number)
    @number = number
    @waggons = []
    @speed = 0
  end
  
  def show_speed
    puts "Скорость поезда №#{@number} составляет #{@speed} км/ч"
  end

  def change_speed(speed)
    @speed = speed
  end

  def stop
    @speed = 0
  end

  def show_waggons_amount
    puts "Количество вагонов(поезд №#{@number}): #{@waggons_amount}"
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
        elsif station_index == @route.stations.size - 1
          puts "Поезд №#{@number} никуда не идет т.к. уже на конечной"
        else
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
    if stopped? && @waggons_amount > 0
      @waggons.pop
    else
      puts "Поезд №#{@number}: нельзя отцеплять вагоны во время движения или если их нет"
    end
  end

  protected
  #данные методы используются только в дочерних классах (или внутри данного класса)
  #все остальные должны быть доступны из вне

  def add_typed_waggon(waggon)
     #проверка проводится в дочернем классе
     @waggons << waggon    
  end

  def stopped?
    @speed == 0
  end
  
end

