#!/usr/bin/env ruby

require_relative 'route'
require_relative 'train'
require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'station'

train1 = PassengerTrain.new('Error Test')
puts train1.valid?
