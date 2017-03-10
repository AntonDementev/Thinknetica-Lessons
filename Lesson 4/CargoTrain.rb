#!/usr/bin/env ruby

CargoWaggon=Class.new

class CargoTrain < Train
  def wagon_class
    CargoWaggon.new
  end
  
  def add_waggon
    super
  end
end
