#!/usr/bin/env ruby
PassengerWaggon=Class.new

class PassengerTrain < Train
  def add_waggon
    if stopped?
      add_typed_waggon(PassengerWaggon.new)
    else
      puts "Поезд №#{@number}: нельзя отцеплять вагоны во время движения или если их нет"
    end
  end 
end
