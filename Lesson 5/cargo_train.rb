#!/usr/bin/env ruby

require_relative 'company'
require_relative 'instance_counter'

class CargoWaggon
  include Company
  include InstanceCounter

  def initialize
    register_instance
  end
end

class CargoTrain < Train
  def check_waggon(waggon)
    waggon.class == CargoWaggon
  end
end
