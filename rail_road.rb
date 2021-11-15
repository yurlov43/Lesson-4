# frozen_string_literal: true

require_relative 'station_management'
require_relative 'train_management'

class RailRoad
  include StationManagement
  include TrainManagement
  def initialize
    @trains = {}
    @wagons = []
    @stations = {}
    @routes = {}
  end

  private

  attr_reader :trains, :routes, :stations
end
