#!/usr/bin/env ruby
class PassengerWaggon; end;

class PassengerTrain < Train
  def check_waggon(waggon)
    waggon.class == PassengerWaggon
  end
end
