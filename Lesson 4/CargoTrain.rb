#!/usr/bin/env ruby
class CargoWaggon; end

class CargoTrain < Train
  def add_waggon(waggon)
    if waggon.class == CargoWaggon
      super(waggon)
    end
  end
end
