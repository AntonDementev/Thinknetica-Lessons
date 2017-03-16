#!/usr/bin/env ruby

require_relative 'Company'
require_relative 'InstanceCounter'

class PassengerWaggon
  include Company
  include InstanceCounter
  attr_reader :seats, :seats_max

  def initialize(seats_max)
    register_instance
    @seats_max = seats_max
    @seats = 0
  end
  
  def add_passenger
    @seats += 1 if @seats < @seats_max
  end
  
  def seats_left
    @seats_max - @seats
  end

end

class PassengerTrain < Train
  def check_waggon(waggon)
    waggon.class == PassengerWaggon
  end
end
