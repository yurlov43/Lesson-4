class Train
  attr_reader :number # public потому что к геттеру обращаются из вне
  attr_reader :route # public потому что к геттеру обращаются из вне
  attr_reader :type # public потому что к геттеру обращаются из вне

  def initialize(number, type)
    @number = number
    @type = type
    @wagons = []
    @speed = 0
  end

  def accelerate(speed_gain = 10)
    self.speed + speed_gain <= 70 ?
      self.speed += speed_gain :
      self.speed = 70
  end

  def braking(speed_decrease = self.speed)
    self.speed > speed_decrease ?
      self.speed -= speed_decrease :
      self.speed = 0
  end

  def attach_wagon(wagon)
    self.wagons << wagon unless self.wagons.include?(wagon)
  end

  def unhook_wagon
    self.wagons.pop
  end

  def add_route(route)
    self.route = route
    self.current_index = 0
    self.route.stations.first.take_train(self)
    nil
  end

  def current_station
    self.route.stations.flatten[current_index]
  end

  def position_in_route
    puts "\tStation: #{previous_station.title} " <<
           "- previous station" unless previous_station.nil?
    puts "\tStation: #{current_station.title} - current position"
    puts "\tStation: #{next_station.title} " <<
           "- next station" unless next_station.nil?
  end

  def move_back
    if previous_station.nil?
      puts "The beginning of the route. There are no stations behind."
    else
      current_station.send_train(self)
      self.current_index -= 1
      current_station.take_train(self)
      puts "The train returned to the station: #{current_station.title}"
    end
  end

  def moving_forward
    if next_station.nil?
      puts "End of the route. There are no stations ahead."
    else
      current_station.send_train(self)
      self.current_index += 1
      current_station.take_train(self)
      puts "The train arrived at the station: #{current_station.title}"
    end
  end

  protected
  # Используются внутри класса или при наследовании
  attr_accessor :speed
  attr_writer :route
  attr_accessor :current_index
  attr_reader :wagons

  def previous_station
    previous_index = current_index - 1
    self.route.stations.flatten[previous_index] if previous_index >= 0
  end

  def next_station
    self.route.stations.flatten[current_index + 1]
  end
end