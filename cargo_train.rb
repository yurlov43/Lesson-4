require_relative 'train'

class CargoTrain < Train
  def initialize(number)
    super(number, "cargo")
  end

  def fill_wagons(cargo_volume)
    wagon_manipulation do |wagon, _|
      if wagon.free_volume >= cargo_volume
        wagon.take_volume(cargo_volume)
        cargo_volume = 0
        break
      end
    end
    raise "No free space" if cargo_volume != 0
  end
end
