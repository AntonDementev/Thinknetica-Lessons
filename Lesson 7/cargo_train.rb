#!/usr/bin/env ruby

require_relative 'company'
require_relative 'instance_counter'

class CargoWaggon
  include Company
  include InstanceCounter
  attr_reader :volume_used, :volume

  def initialize(volume)
    register_instance
    @volume = volume
    @volume_used = 0.0
  end
  
  def use_volume(new_volume)
    @volume_used += new_volume if @volume_used + new_volume < @volume
  end
  
  def volume_left
    @volume - @volume_used
  end
  
end

class CargoTrain < Train
  def check_waggon(waggon)
    waggon.class == CargoWaggon
  end
end
