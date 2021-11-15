# frozen_string_literal: true

require_relative 'rail_road'
require_relative 'route'
require_relative 'station'
require_relative 'train'
require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'wagon'
require_relative 'cargo_wagon'
require_relative 'passenger_wagon'
require_relative 'string'

rail_road = RailRoad.new

def show_menu
  { "1" => "Create station", "2" => "Create a train", "3" => "Create route",
    "4" => "Add a station to the route", "5" => "Remove a station to the route",
    "6" => "Assign a route to a train", "7" => "Add a wagon to a train",
    "8" => "Unhook the carriage from the train",
    "9" => "Move the train forward and backward along the route",
    "10" => "View station list", "11" => "View the list of trains at a station",
    "12" => "View the list of carriages by the train", "13" => "Fill (load) a train",
    "q" => "to quit" }.each { |key, value| puts "#{key} - #{value}".in_blue }
end

create_station = lambda {
  loop do
    rail_road.create_station
    print "Create another station? [y / n]: ".in_yellow
    break if gets.chomp == "n"
  end
}

create_train = lambda {
  loop do
    rail_road.create_train
    print "Create train? [y / n]: ".in_yellow
    break if gets.chomp == "n"
  end
}

create_route = lambda {
  loop do
    rail_road.create_route
    print "Create route? [y / n]: ".in_yellow
    break if gets.chomp == "n"
  end
}

add_station_to_route = -> { rail_road.add_station_to_route }

remove_station_from_route = -> { rail_road.remove_station_from_route }

put_train_on_route = -> { rail_road.put_train_on_route }

attach_wagon_to_train = -> { rail_road.attach_wagon_to_train }

uncouple_wagon_from_train = -> { rail_road.uncouple_wagon_from_train }

move_train_along_route = -> { rail_road.move_train_along_route }

show_stations = -> { rail_road.show_stations }

show_trains_at_station = -> { rail_road.show_trains_at_station }

show_train_wagons = -> { rail_road.show_train_wagons }

load_train = -> { rail_road.load_train }

lambdas = { 1 => create_station, 2 => create_train, 3 => create_route,
            4 => add_station_to_route, 5 => remove_station_from_route,
            6 => put_train_on_route, 7 => attach_wagon_to_train,
            8 => uncouple_wagon_from_train, 9 => move_train_along_route,
            10 => show_stations, 11 => show_trains_at_station,
            12 => show_train_wagons, 13 => load_train }

loop do
  show_menu
  index = gets.chomp.to_i

  case index
  when 1..13
    lambdas[index].call
  else
    break
  end
end
