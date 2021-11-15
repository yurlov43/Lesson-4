# frozen_string_literal: true

require_relative 'instance_counter'
require_relative 'attestation'

class Station
  include Attester
  include InstanceCounter
  attr_accessor :title
  attr_reader :trains

  TITLE_FORMAT = /^[A-Z]{1}[a-z]{1,15}(-{1}\d{1,3})?$/.freeze
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
    puts "At the station: #{title}".in_green

    freight_trains = trains.select do |train|
      train.type == "cargo"
    end
    puts "\t#{freight_trains.size} - freight trains.".in_green

    passenger_trains = trains.select do |train|
      train.type == "passenger"
    end
    puts "\t#{passenger_trains.size} - passenger trains".in_green
  end

  def send_train(train)
    trains.delete(train)
  end

  def show_trains
    puts "List of all trains in the station #{title}:".in_green
    train_manipulation(&:information)
  end

  protected

  def validate!
    raise "Incorrect station name" if title !~ TITLE_FORMAT
  end

  def train_manipulation(&block)
    trains.each(&block)
  end
end
