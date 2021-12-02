# frozen_string_literal: true
require_relative 'wagon'

class PassengerWagon < Wagon
  SEATS_NUMBER_FORMAT = /^\d{1,2}$/.freeze

  validate :total_place, :format, SEATS_NUMBER_FORMAT

  def initialize(seats_number)
    super("passenger", seats_number)
  end

  alias take_place use_place

  alias free_seats_number free_place
end
