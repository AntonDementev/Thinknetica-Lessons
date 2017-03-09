#!/usr/bin/env ruby

class Station
  attr_reader :name
  def initialize(name)
    @name = name
    @trains_list = []
  end
  
  def take_train(train)
    if train.station == nil
      @trains_list << train
      train.set_to_station(self)
    else
      puts "Поезд №#{train.number} не может быть добавлен на станцию #{@name} он уже находится на станции #{train.station.name}"
    end
  end

  def show_trains
    puts "Список поездов на станции #{@name}:\n#{@trains_list}"
  end

  def show_trains_with_type
    freight_trains = []
    passenger_trains = []
    @trains_list.each do |train|
      if train.type == :freight
        freight_trains << train.number
      elsif train.type == :passenger
        passenger_trains << train.number
      end
    end
      puts "Станция #{@name}"
      puts "Грузовые (#{freight_trains.size}):\n#{freight_trains}"
      puts "Пассажирские (#{passenger_trains.size}):\n#{passenger_trains}"

  end

  def send_train(train)
    if @trains_list.index(train) != nil
      @trains_list.delete(train)
      train.go_from_station
    end
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
  attr_reader :number
  attr_reader :type
  attr_reader :station
  def initialize(number, type, waggons_amount)
    @number = number
    case type
      when 0
        @type=:freight
      else
        @type=:passenger
    end
    @waggons_amount = waggons_amount
    @speed = 0
    @route = nil
    @station = nil
  end
  
  def show_speed
    puts "Скорость поезда №#{@number} (#{@type}) составляет #{@speed} км/ч"
  end

  def set_speed(speed)
    @speed = speed
  end

  def stop
    @speed = 0
  end

  def show_waggons_amount
    puts "Количество вагонов(поезд №#{@number}): #{@waggons_amount}"
  end

  def add_waggon
    if @speed == 0
      @waggons_amount += 1
    else
      puts "Поезд №#{train.number}: нельзя прицеплять вагоны во время движения"
    end
  end

  def remove_waggon
    if @speed == 0 && @waggons_amount > 0
      @waggons_amount -= 1
    else
      puts "Поезд №#{train.number}: нельзя отцеплять вагоны во время движения или если их нет"
    end
  end

  def set_route(route)
    @route = route
  end
  
  def go_from_station
    @station = nil
  end
  
  def set_to_station(station)
    @station = station
  end
  
  def goto_next_station
    if !@route.nil?
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
    if !@route.nil?
      station_index = @route.stations.index(@station)
      if station_index.nil?
        puts "Поезд №#{@number} сейчас не на маршруте"
      elsif station_index == 0
        puts "Поезд №#{@number}. Текущая станция: #{@station.name} (начальная), следующая: #{@route.stations[1].name}"
      elsif station_index == @route.stations.size - 1
        puts "Поезд №#{@number}. Текущая станция: #{@station.name} (конечная), предыдущая: #{@route.stations[station_index-1].name}"
      else
        puts "Поезд №#{@number}. Текущая станция: #{@station.name}, следующая: #{@route.stations[station_index+1].name}, предыдущая: #{@route.stations[station_index-1].name}"
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

train1 = Train.new("0001",0,8)
train2 = Train.new("0002",1,7)
train3 = Train.new("0003",0,6)

train1.set_route(route)

8.times {train1.goto_next_station; train1.show_route_stations}

station5.take_train(train2)
station5.take_train(train3)

station5.show_trains_with_type







