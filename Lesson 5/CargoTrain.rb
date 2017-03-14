#!/usr/bin/env ruby

require_relative 'Company'
require_relative 'InstanceCounter'

class CargoWaggon
  include Company
  include InstanceCounter
  self.begin_count
  def initialize
    register_instance
  end
end

class CargoTrain < Train
  def check_waggon(waggon)
    waggon.class == CargoWaggon
  end
end
