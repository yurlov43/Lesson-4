# frozen_string_literal: true

module StationManagement
  def self.included(base)
    base.include InstanceMethods
  end

  module InstanceMethods
    def create_station(title = nil)
      print "Set the name of the new station: ".in_yellow if title.nil?
      title ||= gets.chomp

      begin
        stations[title] ||= Station.new(title)
        puts "Station #{title} created.".in_green
      rescue RuntimeError => error
        puts "#{error.message}. Try again!".in_red
      end
      stations[title]
    end

    def create_route
      starting_station = create_station
      return if starting_station.nil?

      starting_station_title = starting_station.title

      end_station = create_station
      return if end_station.nil?

      end_station_title = end_station.title

      routes["#{starting_station_title}-" +
        end_station_title.to_s] = Route.new(starting_station, end_station)
      puts "Route #{starting_station_title}-#{end_station_title} created.".in_green
    end

    def add_station_to_route
      print "Enter the name of the route: ".in_yellow
      route_name = gets.chomp
      route = routes[route_name]

      if route.nil?
        puts "Route #{route_name} not found.".in_red
      else
        station = create_station
        return if station.nil?

        add_station(route, station)
      end
    end

    def remove_station_from_route
      print "Enter the name of the route: ".in_yellow
      route_name = gets.chomp
      route = routes[route_name]

      if route.nil?
        puts "Route #{route_name} not found.".in_red
      else
        station = create_station
        return if station.nil?

        remove_station(route, station)
      end
    end

    def show_stations
      puts "List of all stations on the railway: ".in_green
      stations.each_key do |station_title|
        puts station_title.to_s.in_green
      end
    end

    def show_trains_at_station
      print "Enter the name of the station: ".in_yellow
      station_title = gets.chomp
      station = stations[station_title]
      if station.nil?
        puts "Station #{station_title} not found.".in_red
      else
        station.show_trains
      end
    end

    private

    def station_no_created?(station_title)
      stations[station_title].nil?
    end

    def add_station(route, station)
      if route.stations.include?(station)
        puts "The route already contains a station #{station.title}.".in_red
      else
        route.add_intermediate_station(station)
        puts "The station #{station.title} has been successfully added to the route.".in_green
      end
    end

    def remove_station(route, station)
      if route.stations.include?(station)
        route.remove_intermediate_station(station)
        puts "The station #{station.title} has been successfully removed from the route.".in_green
      else
        puts "The route does not contain a station #{station.title}.".in_red
      end
    end
  end
end
