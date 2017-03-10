#!/usr/bin/env ruby
CargoWaggon=Class.new

class CargoTrain < Train
  def add_waggon
    if stopped?
      add_typed_waggon(CargoWaggon.new)
    else
      puts "Поезд №#{@number}: нельзя отцеплять вагоны во время движения или если их нет"
    end
  end
  
end
