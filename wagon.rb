require_relative 'manufacturer_company'

class Wagon
  include ManufacturerCompany

  def initialize(type)
    @type = type
  end

  protected
  # Используется внутри класса или при наследовании
  attr_accessor :type
end