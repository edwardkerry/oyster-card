require_relative 'journey'

class Oystercard

  attr_reader :balance, :in_use, :journey

  MAXIMUM_BALANCE = 90
  MINIMUM_CHARGE = 1

  def initialize
    @balance = 0
    @in_use = false
    @journey = Journey.new
  end

  def top_up(amount)
    fail "Balance limit is #{MAXIMUM_BALANCE}" if balance_exceeded(amount)
    @balance += amount
  end

  def touch_in(station)
    fail "Insufficient funds: #{balance}" if low_funds
    @in_use = true
    @journey.start(station)
  end

  def touch_out(station)
    @journey.end(station)
    deduct(MINIMUM_CHARGE)
  end

  def in_journey?
    @in_use
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
