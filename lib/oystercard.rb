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
    fail "Balance limit is #{MAXIMUM_BALANCE}" if balance_exceeded(amount)
    @balance += amount
  end

  def touch_in(station)
    fail "Insufficient funds: #{balance}" if low_funds
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

  def balance_exceeded(amount)
    balance + amount > MAXIMUM_BALANCE
  end

  def low_funds
    balance < MINIMUM_CHARGE
  end

  def deduct(amount)
    @balance -= amount
  end

end
