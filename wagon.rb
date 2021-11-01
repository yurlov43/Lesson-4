class Wagon
  def initialize(type)
    @type = type
  end

  protected
  # Используется внутри класса или при наследовании
  attr_accessor :type
end