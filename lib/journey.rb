class Journey

  PENALTY_FARE = 6

  attr_reader :entry_station

  def initialize(entry_station: nil)
    @entry_station = entry_station
  end

  def complete?
    false
  end

  def fare
    PENALTY_FARE
  end

  def exit(station)
    self
  end

end
