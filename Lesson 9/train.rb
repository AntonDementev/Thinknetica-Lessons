#!/usr/bin/env ruby

require_relative 'company'
require_relative 'instance_counter'
require_relative 'validation'
require_relative 'accessors'

class Train
  include Company
  include InstanceCounter
  include Validation
  extend Accessors

  attr_reader :number, :station, :waggons, :speed
  strong_attr_acessor :route, Route
  validate :number, :presence
  validate :number, :format, /^[0-9a-z]{3}-?[0-9a-z]{2}$/i
  validate :number, :type, String

  @@trains = {}

  def initialize(number)
    @number = number
    @waggons = []
    @speed = 0

    register_instance
    @@trains[number] = self
  end

  def action_with_waggons(block)
    @waggons.each do |waggon|
      block.call(waggon)
    end
  end

  def self.find(number)
    @@trains[number]
  end

  def change_speed(speed)
    @speed = speed
  end

  def stop
    @speed = 0
  end

  def waggons_amount
    @waggons.size
  end

  def go_from_station
    return unless @station
    @station.trains_list.delete(self)
    @station = nil
  end

  def go_to_station(station)
    go_from_station if @station
    station.trains_list << self
    @station = station
  end

  def goto_next_station
    return unless @route
    if @station.nil?
      @route.stations[0].take_train(self)
    else
      station_index = @route.stations.index(@station)

      if station_index.nil?
        @station.send_train(self)
        @route.stations[0].take_train(self)
      elsif station_index < @route.stations.size - 1
        @route.stations[station_index].send_train(self)
        @route.stations[station_index + 1].take_train(self)
      end
    end
  end

  def show_current_station
    return unless @route
    station_index = @route.stations.index(@station)
    print "Поезд №#{@number}"
    if station_index.nil?
      puts ' сейчас не на маршруте'
    else
      puts ". Текущая станция: #{@station.name}"
    end
  end

  def show_next_station
    return unless @route
    station_index = @route.stations.index(@station)
    print "Поезд №#{@number}"
    case station_index
    when nil
      puts ' сейчас не на маршруте'
    when @route.stations.size - 1
      puts ' уже на конечной станции'
    else
      puts ". Следующая станция: #{@route.stations[station_index + 1].name}"
    end
  end

  def show_previous_station
    return unless @route
    station_index = @route.stations.index(@station)
    print "Поезд №#{@number}"
    case station_index
    when nil
      puts ' сейчас не на маршруте'
    when 0
      puts ' пока ещё на начальной станции'
    else
      puts ". Предыдущая станция: #{@route.stations[station_index - 1].name}"
    end
  end

  def remove_waggon
    @waggons.pop if stopped? && !@waggons.empty?
    waggons_amount
  end

  def add_waggon(wagon)
    if stopped?
      @waggons << wagon if check_waggon(wagon)
    end
    waggons_amount
  end

  private

  def stopped?
    @speed.zero?
  end
end
