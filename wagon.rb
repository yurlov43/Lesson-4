# frozen_string_literal: true

require_relative 'manufacturer_company'
require_relative 'validation'

class Wagon
  include Validation
  include ManufacturerCompany
  attr_reader :type

  TOTAL_PLACE_FORMAT = /^\d+$/.freeze
  TYPE_FORMAT = /^cargo|passenger$/.freeze

  validate :total_place, :format, TOTAL_PLACE_FORMAT
  validate :type, :format, TYPE_FORMAT

  def initialize(type, total_place)
    @type = type
    @total_place = total_place
    @used_place = 0
    validate!
  end

  def use_place(value = 1)
    self.used_place += value if value <= free_place
  end

  def free_place
    total_place - used_place
  end

  def information
    print "\tWagon type: #{type.to_s.in_green}"
    print "\tNumber of free seats: #{free_place.to_s.in_green}"
    puts "\tNumber of occupied places: #{used_place.to_s.in_green}"
  end

  protected

  attr_reader :total_place
  attr_accessor :used_place
end
