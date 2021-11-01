class Route
  attr_reader :stations
  attr_reader :intermediate_stations

  def initialize(start_station, end_station)
    @intermediate_stations = []
    @stations = [start_station, @intermediate_stations, end_station]
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
end