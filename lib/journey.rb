class Journey

  PENALTY_FARE = 6

  attr_reader :entry_station, :exit_station

  def initialize(entry_station: nil)
    @entry_station = entry_station
    @complete = false
  end

  def complete?
   @complete
  end

  def fare
    return PENALTY_FARE if penalty?
    1
  end

  def exit(station)
    @exit_station = station
    @complete = true
    self
  end

  def penalty?
    !exit_station
  end

end
