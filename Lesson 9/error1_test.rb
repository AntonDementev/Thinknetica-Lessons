#!/usr/bin/env ruby

require_relative 'route'
require_relative 'train'
require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'station'

station1 = Station.new('Станция 1')
station2 = Station.new('Станция 2')
station3 = Station.new('Станция 3')
station4 = Station.new('Станция 4')
station5 = Station.new('Станция 5')

route = Route.new(station1, station5)
route.add_station(station2)
route.add_station(station3)
route.add_station(station4)

train1 = PassengerTrain.new('000-01')

train1.route = 'Error Test'
