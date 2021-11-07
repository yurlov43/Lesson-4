require_relative 'instance_counter'
require_relative 'attestation'

class Station
  include Attester
  include InstanceCounter
  attr_accessor :title
  attr_reader :trains

  TITLE_FORMAT = /^[A-Z]{1}[a-z]{1,15}(-{1}\d{1,3})?$/

  def initialize(title)
    @title = title
    @trains = []
    validate!
    register_instance
  end

  def self.all
    ObjectSpace.each_object(self).to_a
  end

  def take_train(train)
    trains << train if train.current_station == self
  end

  def trains_by_type
    puts "At the station: #{title}"
    freight_trains = trains.select do |train|
      train.type == "cargo"
    end

    puts "\t#{freight_trains.size} - freight trains."
    passenger_trains = trains.select do |train|
      train.type == "passenger"
   end
    puts "\t#{passenger_trains.size} - passenger trains"
  end

  def send_train(train)
    trains.delete(train)
  end

  def show_trains
    puts "List of all trains in the station #{self.title}:"
    self.trains.each do |train|
      puts "\t#{train.number}"
    end
  end

  protected

  def validate!
    raise "Incorrect station name" if title !~ TITLE_FORMAT
  end
end
