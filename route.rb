# frozen_string_literal: true

require_relative 'instance_counter'
require_relative 'validation'
require_relative 'station'

class Route
  include Validation
  include InstanceCounter
  attr_reader :stations, :intermediate_stations

  validate :start_station, :type, Station
  validate :end_station, :type, Station

  def initialize(start_station, end_station)
    @intermediate_stations = []
    @start_station = start_station
    @end_station = end_station
    @stations = [start_station, @intermediate_stations, end_station]
    validate!
    register_instance
  end

  def add_intermediate_station(intermediate_station)
    intermediate_stations << intermediate_station
  end

  def remove_intermediate_station(intermediate_station)
    intermediate_stations.delete(intermediate_station)
  end

  def print_all_stations
    stations.flatten.each do |station|
      puts station.title unless station.nil?
    end
    nil
  end

  protected

  attr_reader :start_station, :end_station
end
