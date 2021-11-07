require_relative 'manufacturer_company'
require_relative 'attestation'

class Wagon
  include Attester
  include ManufacturerCompany

  def initialize(type)
    @type = type
    validate!
  end

  protected
  # Используется внутри класса или при наследовании
  attr_accessor :type

  def validate!
    raise "Unknown wagon type" if type != "cargo" && type != "passenger"
  end
end
