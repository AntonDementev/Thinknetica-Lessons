#!/usr/bin/env ruby
class PassengerWaggon; end;

class PassengerTrain < Train
  def add_waggon(waggon)
    if waggon.class == PassengerWaggon
      super(waggon)
    end
  end
end
