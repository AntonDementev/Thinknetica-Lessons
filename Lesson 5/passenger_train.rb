#!/usr/bin/env ruby

require_relative 'company'
require_relative 'instance_counter'

class PassengerWaggon
  include Company
  include InstanceCounter

  def initialize
    register_instance
  end
end

class PassengerTrain < Train
  def check_waggon(waggon)
    waggon.class == PassengerWaggon
  end
end
