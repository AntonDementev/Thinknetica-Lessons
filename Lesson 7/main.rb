#!/usr/bin/env ruby

require_relative 'Route'
require_relative 'Train'
require_relative 'CargoTrain'
require_relative 'PassengerTrain'
require_relative 'Station'

def show_cmd_list
  puts "Список команд:
  create_station - создать станцию
  create_train - создать поезд
  add_waggon - прицепить вагон к поезду
  remove_waggon - отцепить вагон от поезда
  use_waggon - использовать вагон
  move_to_station - поместить поезд на станцию
  stations_list - посмотреть список станций
  trains_list - посмотреть список поездов на станции
  waggons_list - посмотреть список вагонов у поезда
  help - вывод этой справки
  exit - выход"
end

def create_station
  puts "Название новой станции?"
  name = gets.chomp
  Station.new(name)
end

def create_train  
  begin  
    puts "Номер нового поезда?"
    number = gets.chomp
    puts "Введите тип поезда: [cargo/pass] = грузововой/пассажирский"
    type = gets.chomp
  
    case type
      when "cargo"
        CargoTrain.new(number)
      when "pass"
        PassengerTrain.new(number)
      else
        puts "Неправильно задан тип, поезд не создан"
    end  
  rescue RuntimeError
    puts "Неправильно задан номер поезда, введите ещё раз" 
    retry
  end 
end

def find_train_with_number
  puts "Введите номер поезда"
  number = gets.chomp
  Train.find(number)
end

def find_station_with_name
  puts "Введите название станции"
  name = gets.chomp
  Station.all.find {|station| station.name == name}
end


def add_waggon
  train=find_train_with_number
  if train
    if train.class == CargoTrain
      puts "Какой объём вагона?"
      volume = gets.to_f
      train.add_waggon(CargoWaggon.new(volume))
    elsif train.class == PassengerTrain
      puts "Сколько мест в вагоне?"
      seats_max = gets.to_i
      train.add_waggon(PassengerWaggon.new(seats_max))
    end
  end  
end

def remove_waggon
  train = find_train_with_number
  if train
    train.remove_waggon
  end 
end

def use_waggon
  train = find_train_with_number
  if train
    waggons_amount=train.waggons_amount
    puts "Введите номер вагона (всего: #{waggons_amount})"
    waggon_number = gets.to_i
    if (waggon_number > 0 && waggon_number <= waggons_amount)
      waggon=train.waggons[waggon_number-1]
      if waggon.is_a? PassengerWaggon
        waggon.add_passenger
      elsif waggon.is_a? CargoWaggon
        puts "На какой объём заполнить вагон? (доступно: #{waggon.volume_left})"
        volume = gets.to_f
        waggon.use_volume(volume)
      end
    else
      puts "Неправильно задан номер вагона"
    end
  end
end

def move_to_station
  train = find_train_with_number
  station = find_station_with_name
  
  if train && station
    station.take_train(train)
    puts "Поезд №#{train.number} помещён на станцию #{station.name}"
  end
end

def show_stations_list
  puts "Список станций (#{Station.all.size}):"
  Station.all.each do |station|
    puts "* #{station.name}"
  end
end


def show_trains_list
  station = find_station_with_name
  puts_trains = lambda {|train| puts "* Поезд №#{train.number}" }
  station.action_with_trains(puts_trains) if station
end

def show_waggons_list
  puts_waggons = lambda {|waggon|
    puts waggon.class
    if waggon.is_a? PassengerWaggon
      puts "* Вагон с #{waggon.seats_left} свободных мест из #{waggon.seats_max}" 
    elsif waggon.is_a? CargoWaggon
      puts "* Вагон с доступным объёмом: #{waggon.volume_left} из #{waggon.volume}"
    end
  }
  
  train = find_train_with_number
  train.action_with_waggons(puts_waggons)
  
end

show_cmd_list

loop do
  cmd = gets.chomp
  case cmd
    when "create_station"
      create_station
    when "create_train"
      create_train
    when "add_waggon"
      add_waggon
    when "remove_waggon"
      remove_waggon
    when "use_waggon"
      use_waggon
    when "move_to_station"
      move_to_station
    when "stations_list"
      show_stations_list
    when "trains_list"
      show_trains_list
    when "waggons_list"
      show_waggons_list
    when "help"
      show_cmd_list
    when "exit"
      break
  end
    
end

