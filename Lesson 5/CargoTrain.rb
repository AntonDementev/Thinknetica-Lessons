#!/usr/bin/env ruby

require_relative 'Company'
require_relative 'InstanceCounter'

class CargoWaggon
  include Company
  include InstanceCounter
end

class CargoTrain < Train
  def check_waggon(waggon)
    waggon.class == CargoWaggon
  end
end
