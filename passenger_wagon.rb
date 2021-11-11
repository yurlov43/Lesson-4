require_relative 'attestation'

class PassengerWagon < Wagon
  include Attester

  SEATS_NUMBER_FORMAT = /^\d{1,2}$/

  def initialize(seats_number)
    @seats_number = seats_number
    @occupied_places_number = 0
    super("passenger")
  end

  def take_place
    self.occupied_places_number += 1 if self.occupied_places_number <= self.seats_number
  end

  def free_seats_number
    self.seats_number - self.occupied_places_number
  end

  def information
    print "\tWagon type: " +
          "\u001b[32;1m" +
          "#{self.type} " +
          "\u001b[37;1m" +
          "\tNumber of free seats: " +
          "\u001b[32;1m" +
          "#{self.free_seats_number} " +
          "\u001b[37;1m" +
          "\tNumber of occupied places: " +
          "\u001b[32;1m" +
          "#{self.occupied_places_number}\n" +
          "\u001b[0m"
  end

  protected

  attr_reader :seats_number
  attr_accessor :occupied_places_number

  def validate!
    raise "Incorrect seats number" if self.seats_number.to_s !~ SEATS_NUMBER_FORMAT
  end
end
