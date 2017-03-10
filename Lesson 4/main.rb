#!/usr/bin/env ruby

require_relative 'Route'
require_relative 'Train'
require_relative 'CargoTrain'
require_relative 'PassengerTrain'
require_relative 'Station'


=begin
     - Создавать станции
     - Создавать поезда
     - Добавлять вагоны к поезду
     - Отцеплять вагоны от поезда
     - Помещать поезда на станцию
     - Просматривать список станций и список поездов на станции
=end

$stations = []
$trains = []


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
  $stations << Station.new(name)
end

def create_train
  puts "Номер нового поезда?"
  number = gets.chomp
  puts "Введите тип поезда: [cargo/pass] = грузововой/пассажирский"
  type = gets.chomp
  case type
    when "cargo"
      $trains << CargoTrain.new(number)
    when "pass"
      $trains << PassengerTrain.new(number)
    else
      puts "Неправильно задан тип, поезд не создан"
  end
end

def find_train_with_number
  puts "Введите номер поезда"
  number = gets.chomp
  $trains.each do |current_train| 
    if current_train.number == number
      $train = current_train
      $train_findded = true
    end
  end
end

def find_station_with_name
  puts "Введите название станции"
  name = gets.chomp
  $stations.each do |current_station| 
    if current_station.name == name
      $station = current_station
      $station_findded = true
    end
  end 
end


def add_waggon
  find_train_with_number
  
  if $train_findded
    $train.add_waggon
    puts "Вагон добавлен (всего #{$train.waggons.size})"
  end  
end

def remove_waggon
  find_train_with_number
  
  if $train_findded
    $train.remove_waggon
    puts "Вагон удалён (осталось #{$train.waggons.size})"
  end 
end

def move_to_station
  find_train_with_number
  find_station_with_name
  
  if $train_findded && $station_findded
    $station.take_train($train)
    puts "Поезд №#{$train.number} помещён на станцию #{$station.name}"
  end
end

def show_stations_list
  puts "Список станций"
  $stations.each do |station|
    puts "* #{station.name}"
  end
end


def show_trains_list
  find_station_with_name
  $station.show_trains
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
    when "remoce_waggon"
      add_waggon
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

