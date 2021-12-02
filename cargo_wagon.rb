# frozen_string_literal: true
require_relative 'wagon'

class CargoWagon < Wagon
  VOLUME_FORMAT = /^[0-9]{1,3}$/.freeze

  validate :total_place, :format, VOLUME_FORMAT

  def initialize(volume)
    super("cargo", volume)
  end

  alias take_volume use_place

  alias free_volume free_place
end
