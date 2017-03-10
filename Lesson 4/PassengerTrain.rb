#!/usr/bin/env ruby
PassengerWaggon=Class.new

class PassengerTrain < Train
  def wagon_class
    PassengerWaggon.new
  end
  
  def add_waggon
    super
  end
end
