class Journey

  PENALTY_FARE = 6

  attr_reader :entry_station, :exit_station

  def initialize(entry_station: nil)
    @entry_station = entry_station
  end

  def complete?
   false
  end

  def fare
    return PENALTY_FARE if penalty?
    1
  end

  def exit(station)
    @exit_station = station
    self
  end

  def penalty?
    !exit_station
  end

end
