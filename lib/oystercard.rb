

class Oystercard
  attr_reader :balance, :in_use, :journey_log

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1

  def initialize(journey_log)
    @balance = 0
    @in_use = false
    @journey_log = journey_log
  end

  def top_up(amount)
    fail "Balance limit is #{MAXIMUM_BALANCE}" if balance_exceeded?(amount)
    @balance += amount
  end

  def touch_in(station)
    deduct(journey_log.charge) if in_journey?
    fail "Insufficient funds: #{balance}" if low_funds?
    @in_use = true
    journey_log.start_journey(station)
  end

  def touch_out(station)
    journey_log.end_journey(station)
    deduct(journey_log.charge)
    journey_log.new_journey
    @in_use = false
  end

  def history
    journey_log.read
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
