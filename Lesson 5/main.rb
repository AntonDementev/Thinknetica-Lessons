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
  move_to_station - поместить поезд на станцию
  stations_list - посмотреть список станций
  trains_list - посмотреть список поездов на станции
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
  Train.find(name)
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
      train.add_waggon(CargoWaggon.new)
    elsif train.class == PassengerTrain
      train.add_waggon(PassengerWaggon.new)
    end
  end  
end

def remove_waggon
  train = find_train_with_number
  if train
    train.remove_waggon
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
  station.show_trains if station
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
    when "move_to_station"
      move_to_station
    when "stations_list"
      show_stations_list
    when "trains_list"
      show_trains_list
    when "help"
      show_cmd_list
    when "exit"
      break
  end
    
end

