require_relative 'instance_counter'
require_relative 'attestation'

class Station
  include Attester
  include InstanceCounter
  attr_accessor :title
  attr_reader :trains

  TITLE_FORMAT = /^[A-Z]{1}[a-z]{1,15}(-{1}\d{1,3})?$/
  @@stations = []

  def initialize(title)
    @title = title
    @trains = []
    validate!
    register_instance
    @@stations << self
  end

  def self.all
    @@stations
  end

  def take_train(train)
    trains << train if train.current_station == self
  end

  def trains_by_type
    puts "\u001b[32;1m" +
         "At the station: #{title}" +
         "\u001b[0m"

    freight_trains = trains.select do |train|
      train.type == "cargo"
    end
    puts "\u001b[32;1m" +
         "\t#{freight_trains.size} - freight trains." +
         "\u001b[0m"

    passenger_trains = trains.select do |train|
      train.type == "passenger"
   end
    puts "\u001b[32;1m" +
         "\t#{passenger_trains.size} - passenger trains" +
         "\u001b[0m"
  end

  def send_train(train)
    trains.delete(train)
  end

  def show_trains
    puts "\u001b[32;1m" +
         "List of all trains in the station #{self.title}:" +
         "\u001b[0m"

    train_manipulation do |train|
      train.information
    end
  end

  protected

  def validate!
    raise "Incorrect station name" if title !~ TITLE_FORMAT
  end

  def train_manipulation(&block)
    trains.each &block
  end
end
