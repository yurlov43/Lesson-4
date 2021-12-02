# frozen_string_literal: true

module TrainManagement
  def self.included(base)
    base.include InstanceMethods
  end

  module InstanceMethods
    def create_train
      print "Set the number of the new train: ".in_yellow
      train_number = gets.chomp
      print "Set the type of the new train (c - cargo, p - passenger): ".in_yellow
      train_type = gets.chomp

      create_cargo_train(train_number) if train_type == "c"
      create_passenger_train(train_number) if train_type == "p"
    end

    def put_train_on_route
      train = find_train
      return if train.nil?

      print "Enter the name of the route: ".in_yellow
      route = routes[gets.chomp]

      if route.nil?
        puts "Route with this name was not found.".in_red
        return
      end

      begin
        train.add_route(route)
        puts "Train #{train.number} has been successfully placed on the route!".in_green
      rescue RuntimeError => error
        puts "#{error.message}.".in_red
      end
    end

    def attach_wagon_to_train
      train = find_train
      return if train.nil?

      attach_cargo_wagon(train) if train.instance_of?(CargoTrain)
      attach_passenger_wagon(train) if train.instance_of?(PassengerTrain)
    end

    def show_train_wagons
      train = find_train
      return if train.nil?

      train.show_wagons
    end

    def uncouple_wagon_from_train
      train = find_train
      return if train.nil?

      print "How number wagons need to be uncoupled: ".in_yellow
      number_wagons = gets.chomp.to_i
      number_wagons.times { train.unhook_wagon }
    end

    def move_train_along_route
      train = find_train
      return if train.nil?

      until train.route.nil?
        print "Where to move the train? [q - quit, f - forward, b - back]: ".in_yellow
        user_response = gets.chomp
        break if user_response == "q"

        train.moving_forward if user_response == "f"
        train.move_back if user_response == "b"
      end
    end

    def load_train
      train = find_train
      return if train.nil?

      print "The number of passengers or cargo to be transported: ".in_yellow
      number = gets.chomp.to_i
      begin
        train.fill_wagons(number)
        puts "Landing (loading) was successful.".in_green
      rescue RuntimeError => e
        puts "#{e.message}.".in_red
      end
    end

    private

    def attach_cargo_wagon(train)
      print "Set the volume of the wagon: ".in_yellow
      volume = gets.chomp.to_i
      cargo_wagon = CargoWagon.new(volume)
      train.attach_wagon(cargo_wagon)
      puts "The wagon is successfully hitched to the train #{train.number}.".in_green
    rescue RuntimeError => e
      puts "#{e.message}. Try again!".in_red
    end

    def attach_passenger_wagon(train)
      print "Set the number of seats in the wagon: ".in_yellow
      seats_number = gets.chomp.to_i
      passenger_wagon = PassengerWagon.new(seats_number)
      train.attach_wagon(passenger_wagon)
      puts "The wagon is successfully hitched to the train #{train.number}.".in_green
    rescue RuntimeError => e
      puts "#{e.message}. Try again!".in_red
    end

    def find_train
      print "Enter the train number: ".in_yellow
      train_number = gets.chomp
      train = trains[train_number]

      puts "Train #{train_number} was not found.".in_red if train.nil?
    end

    def create_cargo_train(train_number)
      cargo_train = CargoTrain.new(train_number)
      trains[train_number] = cargo_train
      puts "A train with a #{train_number} has been created!".in_green
    rescue RuntimeError => e
      puts "#{e.message}. Try again!".in_red
    end

    def create_passenger_train(train_number)
      passenger_train = PassengerTrain.new(train_number)
      trains[train_number] = passenger_train
      puts "A train with a #{train_number} has been created!".in_green
    rescue RuntimeError => e
      puts "#{e.message}. Try again!".in_red
    end
  end
end
