class Oystercard

  MAXIMUM_BALANCE = 90
  MINIMUM_CHARGE = 1

  attr_reader :balance
  attr_reader :entry_station
  attr_reader :exit_station

  def initialize
    @balance = 0
    @entry_station = entry_station
    @exit_station = exit_station
  end

  def top_up(amount)
    raise "Maximum balance of #{MAXIMUM_BALANCE} exceeded" if amount + balance > MAXIMUM_BALANCE
    @balance = @balance + amount
  end

  def deduct(amount)
    @balance = @balance - amount
  end

  def in_journey?
    !!entry_station
  end

  def touch_in(station)
    fail 'Insufficient balance to touch in' if @balance < MINIMUM_CHARGE
    @entry_station = station
  end

  def touch_out(station)
    deduct(MINIMUM_CHARGE)
    @exit_station = station
  end

end
