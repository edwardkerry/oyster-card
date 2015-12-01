class Oystercard

  attr_reader :balance, :in_use, :starting_station, :end_station, :journey, :history

  MAXIMUM_BALANCE = 90
  MINIMUM_CHARGE = 1

  def initialize
    @balance = 0
    @in_use = false
    @starting_station = nil
    @end_station = nil
    @journey = {}
    @history = []
  end

  def top_up(amount)
    fail "Balance limit of #{MAXIMUM_BALANCE} reached" if balance + amount > MAXIMUM_BALANCE
    @balance += amount
  end

  def touch_in(station)
    fail "Insufficient funds: #{balance}" if balance < MINIMUM_CHARGE
    @starting_station = station
  end

  def touch_out(station)
    deduct(MINIMUM_CHARGE)
    @end_station = station
    @journey[@starting_station] = @end_station
    @starting_station = nil
  end

  def in_journey?
    starting_station
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
