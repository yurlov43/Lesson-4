# frozen_string_literal: true

require_relative 'instance_counter'
require_relative 'attestation'

class Route
  include Attester
  include InstanceCounter
  attr_reader :stations, :intermediate_stations

  def initialize(start_station, end_station)
    @intermediate_stations = []
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

  def validate!
    errors = []
    errors << "Start station not set" if stations.first.class != Station
    errors << "End station not set" if stations.last.class != Station

    raise errors.join("\n") unless errors.empty?
  end
end
