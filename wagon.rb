require_relative 'manufacturer_company'
require_relative 'attestation'

class Wagon
  include Attester
  include ManufacturerCompany
  attr_reader :type

  TOTAL_PLACE_FORMAT = /^\d+$/

  def initialize(type, total_place)
    @type = type
    @total_place = total_place
    @used_place = 0
    validate!
  end

  def use_place(value=1)
    self.used_place += value if value <= free_place
  end

  def free_place
    total_place - used_place
  end

  def information
    print "\tWagon type: " +
            "\u001b[32;1m" +
            "#{type} " +
            "\u001b[37;1m" +
            "\tNumber of free seats: " +
            "\u001b[32;1m" +
            "#{free_place} " +
            "\u001b[37;1m" +
            "\tNumber of occupied places: " +
            "\u001b[32;1m" +
            "#{used_place}\n" +
            "\u001b[0m"
  end

  protected

  attr_reader :total_place
  attr_accessor :used_place

  def validate!
    raise "Unknown wagon type" if type != "cargo" && type != "passenger"
    raise "Incorrect wagon total place" if total_place.to_s !~ TOTAL_PLACE_FORMAT
  end
end
