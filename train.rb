require_relative 'manufacturer_company'
require_relative 'instance_counter'
require_relative 'attestation'

class Train
  include Attester
  include ManufacturerCompany
  include InstanceCounter
  attr_reader :number
  attr_reader :route
  attr_reader :type
  attr_reader :wagons

  NUMBER_FORMAT = /^[\d a-z]{3}-?[\d a-z]{2}$/i

  def initialize(number, type)
    @number = number
    @type = type
    @wagons = []
    @speed = 0
    validate!
    register_instance
  end

  def self.find(train_number)
    trains = ObjectSpace.each_object(self).to_a.select do |train|
      train.number == train_number
    end
    trains.size == 0 ? nil : trains.first
  end

  def accelerate(speed_gain = 10)
    self.speed + speed_gain <= 70 ?
    self.speed += speed_gain :
    self.speed = 70
  end

  def braking(speed_decrease = self.speed)
    self.speed > speed_decrease ?
    self.speed -= speed_decrease :
    self.speed = 0
  end

  def attach_wagon(wagon)
    self.wagons << wagon # unless self.wagons.include?(wagon)
  end

  def unhook_wagon
    self.wagons.pop
  end

  def add_route(route)
    self.route = route
    self.current_index = 0
    self.route.stations.first.take_train(self)
    nil
  end

  def current_station
    self.route.stations.flatten[current_index]
  end

  def position_in_route
    puts "\u001b[32;1m" +
         "\tStation: #{previous_station.title} - previous station" +
         "\u001b[0m" unless previous_station.nil?

    puts "\u001b[32;1m" +
         "\tStation: #{current_station.title} - current position" +
         "\u001b[0m"

    puts "\u001b[32;1m" +
         "\tStation: #{next_station.title} - next station" +
         "\u001b[0m" unless next_station.nil?
  end

  def move_back
    if previous_station.nil?
      puts "\u001b[31;1m" +
           "The beginning of the route. There are no stations behind." +
           "\u001b[0m"
    else
      current_station.send_train(self)
      self.current_index -= 1
      current_station.take_train(self)
      puts "\u001b[32;1m" +
           "The train returned to the station: #{current_station.title}" +
           "\u001b[0m"
    end
  end

  def moving_forward
    if next_station.nil?
      puts "\u001b[31;1m" +
           "End of the route. There are no stations ahead." +
           "\u001b[0m"
    else
      current_station.send_train(self)
      self.current_index += 1
      current_station.take_train(self)
      puts "\u001b[32;1m" +
           "The train arrived at the station: #{current_station.title}" +
           "\u001b[0m"
    end
  end

  def show_wagons
    puts "\u001b[32;1m" +
         "List of all wagons in the train #{self.number}:" +
         "\u001b[0m"

    wagon_manipulation do |wagon, wagon_number|
      print "\u001b[37;1m" +
            "Wagon number: " +
            "\u001b[32;1m" +
            "#{wagon_number + 1} " +
            "\u001b[37;1m"
      wagon.information
    end
  end

  def information
    puts "\u001b[37;1m" +
           "Train number: " +
           "\u001b[32;1m" +
           "#{self.number}" +
           "\u001b[37;1m" +
           "\tTrain type: " +
           "\u001b[32;1m" +
           "#{self.type}" +
           "\u001b[37;1m" +
           "\tNumber of wagons: " +
           "\u001b[32;1m" +
           "#{self.wagons.size}" +
           "\u001b[0m"
  end

  protected

  attr_accessor :speed
  attr_writer :route
  attr_accessor :current_index

  def previous_station
    previous_index = current_index - 1
    self.route.stations.flatten[previous_index] if previous_index >= 0
  end

  def next_station
    self.route.stations.flatten[current_index + 1]
  end

  def validate!
    errors = []
    errors << "Incorrect train number" if number !~ NUMBER_FORMAT
    errors << "Unknown train type" if type != "cargo" && type != "passenger"
    raise errors.join('. ') unless errors.empty?
  end

  def wagon_manipulation(&block)
    self.wagons.each_with_index &block
  end
end
