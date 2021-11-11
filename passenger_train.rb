require_relative 'train'

class PassengerTrain < Train
  def initialize(number)
    super(number, "passenger")
  end

  def fill_wagons(passengers_number)
    wagon_manipulation do |wagon, _|
      while wagon.free_seats_number > 0 && passengers_number > 0
        wagon.take_place
        passengers_number -= 1
      end
      return if passengers_number == 0
    end
    raise "No free space. Not accommodated #{passengers_number} passengers" if passengers_number != 0
  end
end