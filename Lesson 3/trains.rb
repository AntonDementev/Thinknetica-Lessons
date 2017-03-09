#!/usr/bin/env ruby

class Station
  attr_reader :name, :trains_list
  
  def initialize(name)
    @name = name
    @trains_list = []
  end
  
  def take_train(train)
      train.go_to_station(self)
  end

  def show_trains
    puts "Список поездов на станции #{@name}:\n#{@trains_list}"
  end

  def show_trains_with_type(type)
    trains_this_type = @trains_list.select {|train| train.type == type}
     
    print "Станция #{@name}. " 
    print "Грузовые поезда " if type == :freight
    print "Пассажирские поезда " if type == :passenger
    puts "(#{trains_this_type.size} шт.):"
    
    trains_this_type.each {|train| puts "* Поезд №#{train.number}"} 
  end

  def send_train(train)
      train.go_from_station
  end
end

class Route 
  attr_reader :stations
  
  def initialize(begin_station, end_station)
    @stations = [begin_station, end_station]
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

class Train
  attr_reader :number, :type, :station
  attr_accessor :route
  def initialize(number, type, waggons_amount)
    @number = number
    @type = type 
    @waggons_amount = waggons_amount
    @speed = 0
    @route = nil
    @station = nil
  end
  
  def show_speed
    puts "Скорость поезда №#{@number} (#{@type}) составляет #{@speed} км/ч"
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

  def stopped?
    @speed == 0
  end

  def add_waggon
    if stopped?
      @waggons_amount += 1
    else
      puts "Поезд №#{@number}: нельзя прицеплять вагоны во время движения"
    end
  end

  def remove_waggon
    if stopped? && @waggons_amount > 0
      @waggons_amount -= 1
    else
      puts "Поезд №#{@number}: нельзя отцеплять вагоны во время движения или если их нет"
    end
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

  def show_route_stations
    if @route
      station_index = @route.stations.index(@station)
      case station_index
        when nil
          puts "Поезд №#{@number} сейчас не на маршруте"
        when 0
          puts "Поезд №#{@number}. Текущая станция: #{@station.name} (начальная), следующая: #{@route.stations[1].name}"
        when @route.stations.size - 1
          puts "Поезд №#{@number}. Текущая станция: #{@station.name} (конечная), предыдущая: #{@route.stations[station_index-1].name}"
        else
          puts "Поезд №#{@number}. Текущая станция: #{@station.name}, следующая: #{@route.stations[station_index+1].name}, предыдущая: #{@route.stations[station_index-1].name}"
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

end


# проверка:

station1 = Station.new("Станция 1")
station2 = Station.new("Станция 2")
station3 = Station.new("Станция 3")
station4 = Station.new("Станция 4")
station5 = Station.new("Станция 5")


route = Route.new(station1,station5)
route.add_station(station2)
route.add_station(station3)
route.add_station(station4)


train1 = Train.new("0001",:freight,8)
train2 = Train.new("0002",:passenger,7)
train3 = Train.new("0003",:freight,6)

train1.route=route
train1.show_route_stations

8.times {train1.goto_next_station; train1.show_current_station; train1.show_next_station}

station5.take_train(train2)
station5.take_train(train3)

station5.show_trains_with_type(:freight)

train1.show_waggons_amount
train1.add_waggon
train1.show_waggons_amount
