require_relative 'manufacturer_company'
require_relative 'attestation'

class Wagon
  include Attester
  include ManufacturerCompany
  attr_reader :type

  def initialize(type)
    @type = type
    validate!
  end

  protected

  def validate!
    raise "Unknown wagon type" if type != "cargo" && type != "passenger"
  end
end
