# frozen_string_literal: true

require_relative 'manufacturer_company'
require_relative 'instance_counter'
require_relative 'attestation'

class Train
  include Attester
  include ManufacturerCompany
  include InstanceCounter
  attr_reader :number, :route, :type, :wagons

  NUMBER_FORMAT = /^[\d a-z]{3}-?[\d a-z]{2}$/i.freeze
  @@trains = []

  def initialize(number, type)
    @number = number
    @type = type
    @wagons = []
    @speed = 0
    validate!
    register_instance
    @@trains << self
  end

  def self.find(train_number)
    @@trains.detect { |train| train.number == train_number }
  end

  def accelerate(speed_gain = 10)
    speed + speed_gain <= 70 ? self.speed += speed_gain : self.speed = 70
  end

  def braking(speed_decrease = self.speed)
    self.speed > speed_decrease ? self.speed -= speed_decrease : self.speed = 0
  end

  def attach_wagon(wagon)
    wagons << wagon # unless self.wagons.include?(wagon)
  end

  def unhook_wagon
    wagons.pop
  end

  def add_route(route)
    self.route = route
    self.current_index = 0
    self.route.stations.first.take_train(self)
    nil
  end

  def current_station
    route.stations.flatten[current_index]
  end

  def position_in_route
    unless previous_station.nil?
      puts "\tStation: #{previous_station.title} - previous station".in_green
    end
    puts "\tStation: #{current_station.title} - current position".in_green
    puts "\tStation: #{next_station.title} - next station".in_green unless next_station.nil?
  end

  def move_back
    if previous_station.nil?
      puts "The beginning of the route. There are no stations behind.".in_red
    else
      current_station.send_train(self)
      self.current_index -= 1
      current_station.take_train(self)
      puts "The train returned to the station: #{current_station.title}".in_green
    end
  end

  def moving_forward
    if next_station.nil?
      puts "End of the route. There are no stations ahead.".in_red
    else
      current_station.send_train(self)
      self.current_index += 1
      current_station.take_train(self)
      puts "The train arrived at the station: #{current_station.title}".in_green
    end
  end

  def show_wagons
    puts "List of all wagons in the train #{number}:".in_green
    wagon_manipulation do |wagon, wagon_number|
      print "Wagon number: #{(wagon_number + 1).to_s.in_green}"
      wagon.information
    end
  end

  def information
    print "Train number: #{number.to_s.to_s.in_green}"
    print "\tTrain type: #{type.to_s.to_s.in_green}"
    puts "\tNumber of wagons: #{wagons.size.to_s.in_green}"
  end

  protected

  attr_accessor :current_index, :speed
  attr_writer :route

  def previous_station
    previous_index = current_index - 1
    route.stations.flatten[previous_index] if previous_index >= 0
  end

  def next_station
    route.stations.flatten[current_index + 1]
  end

  def validate!
    errors = []
    errors << "Incorrect train number" if number !~ NUMBER_FORMAT
    errors << "Unknown train type" if type != "cargo" && type != "passenger"
    raise errors.join(". ") unless errors.empty?
  end

  def wagon_manipulation(&block)
    wagons.each_with_index(&block)
  end
end
