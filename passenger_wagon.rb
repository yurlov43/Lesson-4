# frozen_string_literal: true

class PassengerWagon < Wagon
  SEATS_NUMBER_FORMAT = /^\d{1,2}$/.freeze

  def initialize(seats_number)
    super("passenger", seats_number)
  end

  alias take_place use_place

  alias free_seats_number free_place

  protected

  def validate!
    raise "Incorrect seats number" if total_place.to_s !~ SEATS_NUMBER_FORMAT
  end
end
