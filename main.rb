require_relative 'rail_road'
require_relative 'route'
require_relative 'station'
require_relative 'train'
require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'wagon'
require_relative 'cargo_wagon'
require_relative 'passenger_wagon'

rail_road = RailRoad.new

loop do
  puts "\n==================================================\n" +
       "\u001b[34;1m" +
       " 1 - Создать станцию\n" +
       " 2 - Создать поезд\n" +
       " 3 - Создать маршрут\n" +
       " 4 - Добавить или удалить станцию в маршрут\n" +
       " 5 - Назначить маршрут поезду\n" +
       " 6 - Добавить вагон к поезду\n" +
       " 7 - Отцепить вагон от поезда\n" +
       " 8 - Перемещать поезд по маршруту вперед и назад\n" +
       " 9 - Просматривать список станций\n" +
       " 10 - Просматривать список поездов на станции\n" +
       " 11 - Посмотреть список вагонов у поезда\n" +
       " 12 - Заполнить (загрузить) поезд\n" +
       " q - to quit\n" +
       "\u001b[0m" +
       "=================================================="

  case gets.chomp.to_i
  when 1
    loop do
      rail_road.create_station
      print "\u001b[33;1m" +
            "Create another station? [y / n]: " +
            "\u001b[0m"
      break if gets.chomp == "n"
    end

  when 2
    loop do
      rail_road.create_train
      print "\u001b[33;1m" +
            "Create train? [y / n]: " +
            "\u001b[0m"
      break if gets.chomp == "n"
    end

  when 3
    loop do
      rail_road.create_route
      print "\u001b[33;1m" +
            "Create route? [y / n]: " +
            "\u001b[0m"
      break if gets.chomp == "n"
    end
  when 4
      rail_road.add_or_remove_station_to_route
  when 5
    rail_road.put_train_on_route
  when 6
    rail_road.attach_wagon_to_train
  when 7
    rail_road.uncouple_wagon_from_train
  when 8
    rail_road.move_train_along_route
  when 9
    rail_road.show_stations
  when 10
    rail_road.show_trains_at_station
  when 11
    rail_road.show_train_wagons
  when 12
    rail_road.load_train
  else
    break
  end
end
