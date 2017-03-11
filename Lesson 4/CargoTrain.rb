#!/usr/bin/env ruby
class CargoWaggon; end;

class CargoTrain < Train
  def check_waggon(waggon)
    waggon.class == CargoWaggon
  end
end
