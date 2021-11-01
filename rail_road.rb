class RailRoad

  def initialize
    @trains = {}
    @wagons = []
    @stations = {}
    @routes = {}
  end

  def create_station(title=nil)
    # - Создавать станции
    if title.nil?
      print "Set the name of the new station: "
      title = gets.chomp
    end

    if station_no_created?(title)
      self.stations[title] = Station.new(title)
      puts "Station #{title} created."
    end
  end

  def create_train
    # - Создавать поезда
    print "Set the number of the new train: "
    train_number = gets.chomp
    print "Set the type of the new train (c - cargo, p - passenger): "
    train_type = gets.chomp
    self.trains[train_number] = CargoTrain.new(train_number) if train_type == "c"
    self.trains[train_number] = PassengerTrain.new(train_number) if train_type == "p"
    puts "A train with a #{train_number} has been created!"
  end

  def create_route
    # - Создавать маршруты
    print "Enter the name of the starting station: "
    starting_station_title = gets.chomp
    create_station(starting_station_title)
    starting_station = self.stations[starting_station_title]

    print "Enter the name of the end station: "
    end_station_title = gets.chomp
    create_station(end_station_title)
    end_station = self.stations[end_station_title]

    self.routes["#{starting_station_title}-" +
                  "#{end_station_title}"] = Route.new(starting_station, end_station)
    puts "Route #{starting_station_title}-#{end_station_title} created."
  end

  def add_or_remove_station_to_route
    # - Управлять станциями в маршруте (добавлять, удалять)
    print "Enter the name of the route: "
    route_name = gets.chomp
    route = self.routes[route_name]

    until route.nil?
      print "Enter the title of the station (q - to quit): "
      station_title = gets.chomp
      break if station_title == "q"
      create_station(station_title)
      station = self.stations[station_title]
      print "Add or remove station? [a / r]: "
      user_response = gets.chomp
      if user_response == "a" && !route.stations.include?(station)
        route.add_intermediate_station(station)
      elsif user_response == "r" && route.stations.include?(station)
        route.remove_intermediate_station(station)
      end
    end

    puts "Route #{route_name} not found." if route.nil?
  end

  def put_train_on_route
    # - Назначать маршрут поезду
    print "Enter the train number: "
    train_number = gets.chomp

    if self.trains.key?(train_number)
      print "Enter the name of the route: "
      route_name = gets.chomp

      if self.routes.key?(route_name)
        train = self.trains[train_number]
        route = self.routes[route_name]
        train.add_route(route)
      else
        puts "Route with this name was not found."
      end

    else
      puts "No train with this number found."
    end
  end

  def attach_wagon_to_train
    # - Добавлять вагоны к поезду
    print "Enter the train number: "
    train_number = gets.chomp

    if self.trains.key?(train_number)
      train = self.trains[train_number]
      print "How number wagons need to be added: "
      number_wagons = gets.chomp.to_i
      number_wagons.times do
        wagon = CargoWagon.new if train.type == "cargo"
        wagon = PassengerWagon.new if train.type == "passenger"
        train.attach_wagon(wagon)
      end
    end
  end

  def uncouple_wagon_from_train
    # - Отцеплять вагоны от поезда
    print "Enter the train number: "
    train_number = gets.chomp

    if self.trains.key?(train_number)
      train = self.trains[train_number]
      print "How number wagons need to be uncoupled: "
      number_wagons = gets.chomp.to_i
      number_wagons.times {train.unhook_wagon}
    end
  end

  def move_train_along_route
    # - Перемещать поезд по маршруту
    print "Enter the train number: "
    train_number = gets.chomp

    if self.trains.key?(train_number)
      train = self.trains[train_number]
      until train.route.nil?
        print "Where to move the train? [q - quit, f - forward, b - back]: "
        user_response = gets.chomp
        break if user_response == "q"
        train.moving_forward if user_response == "f"
        train.move_back if user_response == "b"
      end
    else
      puts "No train with this number found."
    end
  end

  def show_stations
    # - Просматривать список станций
    puts "List of all stations on the railway: "
    self.stations.each_key do |station_title|
      puts "\t#{station_title}"
    end
  end

  def show_trains_at_station
    # - Просматривать список поездов на станции
    print "Enter the name of the station: "
    station_title = gets.chomp
    station = self.stations[station_title]
    if station.nil?
      puts "Station #{station_title} not found."
    else
      station.show_trains
    end
  end

  private
  # Используются исключительно внутри класса
  attr_reader :trains
  attr_reader :stations
  attr_reader :routes

  def station_no_created?(station_title)
    self.stations[station_title].nil?
  end
end
