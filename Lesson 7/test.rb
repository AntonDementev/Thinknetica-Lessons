#!/usr/bin/env ruby

require_relative 'route'
require_relative 'train'
require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'station'

station1 = Station.new("Станция 1")
station2 = Station.new("Станция 2")
station3 = Station.new("Станция 3")
station4 = Station.new("Станция 4")
station5 = Station.new("Станция 5")


route = Route.new(station1,station5)
route.add_station(station2)
route.add_station(station3)
route.add_station(station4)


train1 = PassengerTrain.new("000-01")
train2 = CargoTrain.new("000-02")
train3 = PassengerTrain.new("000-03")

train2.add_waggon(CargoWaggon.new(120.0))
train2.add_waggon(CargoWaggon.new(120.0))
train2.add_waggon(CargoWaggon.new(120.0))

train1.add_waggon(PassengerWaggon.new(78))
train1.add_waggon(PassengerWaggon.new(78))
train1.add_waggon(PassengerWaggon.new(78))
train1.add_waggon(PassengerWaggon.new(78))

train2.waggons[1].use_volume(45.5)
train1.waggons[0].add_passenger
train1.waggons[0].add_passenger

puts_waggons = lambda {|waggon|
  puts waggon.class
  if waggon.is_a? PassengerWaggon
    puts "* Вагон с #{waggon.seats_left} свободных мест из #{waggon.seats_max}" 
  elsif waggon.is_a? CargoWaggon
    puts "* Вагон с доступным объёмом: #{waggon.volume_left} из #{waggon.volume}"
  end
}

train2.action_with_waggons(puts_waggons)
train1.action_with_waggons(puts_waggons)

station1.take_train(train1)
station1.take_train(train2)

puts_trains = lambda {|train| puts "* Поезд №#{train.number}" }

puts "#{station1.name}:"
station1.action_with_trains(puts_trains)


