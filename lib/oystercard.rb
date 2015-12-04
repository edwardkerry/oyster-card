class Oystercard
  attr_reader :balance, :journey, :in_use

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1

  def initialize(journey_klass)
    @balance = 0
    @in_use = false
    @journey = journey_klass.new
  end

  def top_up(amount)
    fail "Balance limit is #{MAXIMUM_BALANCE}" if balance_exceeded?(amount)
    @balance += amount
  end

  def touch_in(station)
    deduct(journey.fare) if in_journey?
    fail "Insufficient funds: #{balance}" if low_funds?
    @in_use = true
    journey.start(station)
  end

  def touch_out(station)
    journey.end_journey(station)
    deduct(journey.fare)
    journey.clear
    @in_use = false
  end

  private

  def balance_exceeded?(amount)
    balance + amount > MAXIMUM_BALANCE
  end

  def low_funds?
    balance < MINIMUM_BALANCE
  end

  def deduct(amount)
    @balance -= amount
  end

  def in_journey?
    in_use
  end

end
