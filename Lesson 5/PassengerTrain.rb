#!/usr/bin/env ruby

require_relative 'Company'
require_relative 'InstanceCounter'

class PassengerWaggon
  include Company
  include InstanceCounter
  self.begin_count
  def initialize
    register_instance
  end
end

class PassengerTrain < Train
  def check_waggon(waggon)
    waggon.class == PassengerWaggon
  end
end
