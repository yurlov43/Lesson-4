# frozen_string_literal: true

class CargoWagon < Wagon
  VOLUME_FORMAT = /^[0-9]{1,3}$/.freeze

  def initialize(volume)
    super("cargo", volume)
  end

  alias take_volume use_place

  alias free_volume free_place

  protected

  def validate!
    raise "Incorrect wagon volume" if total_place.to_s !~ VOLUME_FORMAT
  end
end
