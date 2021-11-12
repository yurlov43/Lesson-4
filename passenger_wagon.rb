class PassengerWagon < Wagon

  SEATS_NUMBER_FORMAT = /^\d{1,2}$/

  def initialize(seats_number)
    super("passenger", seats_number)
  end

  def take_place
    use_place
  end

  def free_seats_number
    free_place
  end

  protected

  def validate!
    raise "Incorrect seats number" if total_place.to_s !~ SEATS_NUMBER_FORMAT
  end
end
