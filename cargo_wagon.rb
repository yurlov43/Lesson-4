require_relative 'attestation'

class CargoWagon < Wagon
  include Attester

  VOLUME_FORMAT = /^[0-9]{1,3}$/

  def initialize(volume)
    @volume = volume
    @occupied_volume = 0
    super("cargo")
  end

  def take_volume(cargo_volume)
    self.occupied_volume += cargo_volume if self.occupied_volume + cargo_volume <= self.volume
  end

  def free_volume
    self.volume - self.occupied_volume
  end

  def information
    print "\tWagon type: " +
          "\u001b[32;1m" +
          "#{self.type} " +
          "\u001b[37;1m" +
          "\tFree volume: " +
          "\u001b[32;1m" +
          "#{self.free_volume} " +
          "\u001b[37;1m" +
          "\tAmount of occupied volume: " +
          "\u001b[32;1m" +
          "#{self.occupied_volume}\n" +
          "\u001b[0m"
  end

  protected

  attr_reader :volume
  attr_accessor :occupied_volume

  def validate!
    raise "Incorrect wagon volume" if self.volume.to_s !~ VOLUME_FORMAT
  end
end