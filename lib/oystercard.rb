require_relative 'journey'

class Oystercard

  attr_reader :balance, :journey, :in_use

  MAXIMUM_BALANCE = 90


  def initialize
    @balance = 0
    @in_use = false
    @journey = Journey.new
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
    journey.end(station)
    deduct(journey.fare)
    @in_use = false
  end

  private

  def balance_exceeded?(amount)
    balance + amount > MAXIMUM_BALANCE
  end

  def low_funds?
    balance < Journey::MINIMUM_FARE
  end

  def deduct(amount)
    @balance -= amount
  end

  def in_journey?
    in_use
  end

end
