class Oystercard

  MAXIMUM_BALANCE = 90
  MINIMUM_CHARGE = 1

  attr_reader :balance
  attr_accessor :journeys

  def initialize
    @balance = 0
    @journeys = {}
  end

  def top_up(amount)
    raise "Maximum balance of #{MAXIMUM_BALANCE} exceeded" if amount + balance > MAXIMUM_BALANCE
    @balance = @balance + amount
  end

  def deduct(amount)
    @balance = @balance - amount
  end

  def in_journey?
    @journeys
  end

  def touch_in(station)
    fail 'Insufficient balance to touch in' if @balance < MINIMUM_CHARGE
    @journeys[:entry_station] = station
  end

  def touch_out(station)
    deduct(MINIMUM_CHARGE)
    @journeys[:exit_station] = station
  end

end
