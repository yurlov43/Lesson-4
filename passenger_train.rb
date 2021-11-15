# frozen_string_literal: true

require_relative 'train'

class PassengerTrain < Train
  def initialize(number)
    super(number, "passenger")
  end

  def fill_wagons(passengers_number)
    wagon_manipulation do |wagon, _|
      while wagon.free_seats_number.positive? && passengers_number.positive?
        wagon.take_place
        passengers_number -= 1
      end
      return if passengers_number.zero?
    end
    raise "No free space. Not accommodated #{passengers_number} passengers"
  end
end
