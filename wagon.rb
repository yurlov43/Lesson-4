# frozen_string_literal: true

require_relative 'manufacturer_company'
require_relative 'validation'
require_relative 'accessors'

class Wagon
  include Validation
  include Accessors
  include ManufacturerCompany
  attr_reader :type
  attr_accessor_with_history :used_place

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
end
