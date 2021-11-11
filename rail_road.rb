class RailRoad

  def initialize
    @trains = {}
    @wagons = []
    @stations = {}
    @routes = {}
  end

  def create_station(title=nil)
    if title.nil?
      print "\u001b[33;1m" +
            "Set the name of the new station: " +
            "\u001b[0m"
      title = gets.chomp
    end

    if station_no_created?(title)
      begin
        self.stations[title] = Station.new(title)
        puts "\u001b[32;1m" +
             "Station #{title} created." +
             "\u001b[0m"
      rescue RuntimeError => error
        puts "\u001b[31;1m" +
             "#{error.message}. Try again!" +
             "\u001b[0m"
      end
    end
  end

  def create_train
    attempts_number = 0
    begin
      print "\u001b[33;1m" +
            "Set the number of the new train: " +
            "\u001b[0m"
      train_number = gets.chomp
      print "\u001b[33;1m" +
            "Set the type of the new train (c - cargo, p - passenger): " +
            "\u001b[0m"
      train_type = gets.chomp

      case train_type
      when "c"
        self.trains[train_number] = CargoTrain.new(train_number)
      when "p"
        self.trains[train_number] = PassengerTrain.new(train_number)
      else
        self.trains[train_number] = Train.new(train_number, train_type)
      end

      puts "\u001b[32;1m" +
           "A train with a #{train_number} has been created!" +
           "\u001b[0m"
    rescue RuntimeError => error
      attempts_number += 1
      puts "\u001b[31;1m" +
           "#{error.message}. Try again!" +
           "\u001b[0m"
      retry if attempts_number < 3
    end
  end

  def create_route
    print "\u001b[33;1m" +
          "Enter the name of the starting station: " +
          "\u001b[0m"
    starting_station_title = gets.chomp
    create_station(starting_station_title)
    return if station_no_created?(starting_station_title)
    starting_station = self.stations[starting_station_title]

    print "\u001b[33;1m" +
          "Enter the name of the end station: " +
          "\u001b[0m"
    end_station_title = gets.chomp
    create_station(end_station_title)
    return if station_no_created?(end_station_title)
    end_station = self.stations[end_station_title]

    self.routes["#{starting_station_title}-" +
                "#{end_station_title}"] = Route.new(starting_station, end_station)
    puts "\u001b[32;1m" +
         "Route #{starting_station_title}-#{end_station_title} created." +
         "\u001b[0m"
  end

  def add_or_remove_station_to_route
    print "\u001b[33;1m" +
          "Enter the name of the route: " +
          "\u001b[0m"
    route_name = gets.chomp
    route = self.routes[route_name]

    until route.nil?
      print "\u001b[33;1m" +
            "Enter the title of the station (q - to quit): " +
            "\u001b[0m"
      station_title = gets.chomp
      break if station_title == "q"
      create_station(station_title)
      return if station_no_created?(station_title)
      station = self.stations[station_title]
      print "\u001b[33;1m" +
            "Add or remove station? [a / r]: " +
            "\u001b[0m"
      user_response = gets.chomp
      if user_response == "a" && !route.stations.include?(station)
        route.add_intermediate_station(station)
      elsif user_response == "r" && route.stations.include?(station)
        route.remove_intermediate_station(station)
      end
    end

    puts "\u001b[31;1m" +
         "Route #{route_name} not found." +
         "\u001b[0m" if route.nil?
  end

  def put_train_on_route
    print "\u001b[33;1m" +
          "Enter the train number: " +
          "\u001b[0m"
    train_number = gets.chomp

    if self.trains.key?(train_number)
      print "\u001b[33;1m" +
            "Enter the name of the route: " +
            "\u001b[0m"
      route_name = gets.chomp

      if self.routes.key?(route_name)
        train = self.trains[train_number]
        route = self.routes[route_name]
        train.add_route(route)

        puts "\u001b[32;1m" +
             "Train #{train_number} has been successfully placed on the #{route_name} route!" +
             "\u001b[0m"
      else
        puts "\u001b[31;1m" +
             "Route with this name was not found." +
             "\u001b[0m"
      end

    else
      puts "\u001b[31;1m" +
           "No train with this number found." +
           "\u001b[0m"
    end
  end

  def attach_wagon_to_train
    print "\u001b[33;1m" +
          "Enter the train number: " +
          "\u001b[0m"
    train_number = gets.chomp

    if self.trains.key?(train_number)
      train = self.trains[train_number]
      print "\u001b[33;1m" +
            "How number wagons need to be added: " +
            "\u001b[0m"
      number_wagons = gets.chomp.to_i
      number_wagons.times do
        case train.type
        when "cargo"
          attempts_number = 0
          begin
            print "\u001b[33;1m" +
                  "Set the volume of the wagon: " +
                  "\u001b[0m"
            volume = gets.chomp.to_i
            wagon = CargoWagon.new(volume)
            train.attach_wagon(wagon)
            puts "\u001b[32;1m" +
                 "The wagon is successfully hitched to the train #{train_number}." +
                 "\u001b[0m"
          rescue RuntimeError => error
            attempts_number += 1
            puts "\u001b[31;1m" +
                 "#{error.message}. Try again!" +
                 "\u001b[0m"
            retry if attempts_number < 3
          end
        when "passenger"
          attempts_number = 0
          begin
            print "\u001b[33;1m" +
                  "Set the number of seats in the wagon: " +
                  "\u001b[0m"
            seats_number = gets.chomp.to_i
            wagon = PassengerWagon.new(seats_number)
            train.attach_wagon(wagon)
            puts "\u001b[32;1m" +
                 "The wagon is successfully hitched to the train #{train_number}." +
                 "\u001b[0m"
          rescue RuntimeError => error
            attempts_number += 1
            puts "\u001b[31;1m" +
                 "#{error.message}. Try again!" +
                 "\u001b[0m"
            retry if attempts_number < 3
          end
        end
      end
    else
      puts "\u001b[31;1m" +
           "Train #{train_number} was not found." +
           "\u001b[0m"
    end
  end

  def show_train_wagons
    print "\u001b[33;1m" +
            "Enter the train number: " +
            "\u001b[0m"
    train_number = gets.chomp

    if self.trains.key?(train_number)
      train = self.trains[train_number]
      train.show_wagons
    else
      puts "\u001b[31;1m" +
           "Train #{train_number} was not found." +
           "\u001b[0m"
    end
  end

  def uncouple_wagon_from_train
    print "\u001b[33;1m" +
          "Enter the train number: " +
          "\u001b[0m"
    train_number = gets.chomp

    if self.trains.key?(train_number)
      train = self.trains[train_number]
      print "\u001b[33;1m" +
            "How number wagons need to be uncoupled: " +
            "\u001b[0m"
      number_wagons = gets.chomp.to_i
      number_wagons.times {train.unhook_wagon}
    end
  end

  def move_train_along_route
    print "\u001b[33;1m" +
          "Enter the train number: " +
          "\u001b[0m"
    train_number = gets.chomp

    if self.trains.key?(train_number)
      train = self.trains[train_number]
      until train.route.nil?
        print "\u001b[33;1m" +
              "Where to move the train? [q - quit, f - forward, b - back]: " +
              "\u001b[0m"
        user_response = gets.chomp
        break if user_response == "q"
        train.moving_forward if user_response == "f"
        train.move_back if user_response == "b"
      end
    else
      puts "\u001b[31;1m" +
           "No train with this number found." +
           "\u001b[0m"
    end
  end

  def show_stations
    puts "\u001b[32;1m" +
         "List of all stations on the railway: " +
         "\u001b[0m"
    self.stations.each_key do |station_title|
      puts "\u001b[32;1m" +
           "#{station_title}" +
           "\u001b[0m"
    end
  end

  def show_trains_at_station
    print "\u001b[33;1m" +
          "Enter the name of the station: " +
          "\u001b[0m"
    station_title = gets.chomp
    station = self.stations[station_title]
    if station.nil?
      puts "\u001b[31;1m" +
           "Station #{station_title} not found." +
           "\u001b[0m"
    else
      station.show_trains
    end
  end

  def load_train
    print "\u001b[33;1m" +
          "Enter the train number: " +
          "\u001b[0m"
    train_number = gets.chomp

    if self.trains.key?(train_number)
      train = self.trains[train_number]
      print "\u001b[33;1m" +
            "The number of passengers or cargo to be transported: " +
            "\u001b[0m"
      number = gets.chomp.to_i
      begin
        train.fill_wagons(number)
        puts "\u001b[32;1m" +
             "Landing (loading) was successful." +
             "\u001b[0m"
      rescue RuntimeError => error
        puts "\u001b[31;1m" +
             "#{error.message}." +
             "\u001b[0m"
      end
    else
      puts "\u001b[31;1m" +
           "Train #{train_number} was not found." +
           "\u001b[0m"
    end
  end

  private

  attr_reader :trains
  attr_reader :stations
  attr_reader :routes

  def station_no_created?(station_title)
    self.stations[station_title].nil?
  end
end
