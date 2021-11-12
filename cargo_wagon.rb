class CargoWagon < Wagon

  VOLUME_FORMAT = /^[0-9]{1,3}$/

  def initialize(volume)
    super("cargo", volume)
  end

  def take_volume(cargo_volume)
    use_place(cargo_volume)
  end

  def free_volume
    free_place
  end

  protected

  def validate!
    raise "Incorrect wagon volume" if total_place.to_s !~ VOLUME_FORMAT
  end
end