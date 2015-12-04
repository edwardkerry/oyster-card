class Journey

  attr_reader :current_journey, :entry_station, :exit_station, :PENALTY_FARE, :MINIMUM_FARE

  PENALTY_FARE = 6
  MINIMUM_FARE = 1

  def initialize
    @entry_station = nil
    @exit_station = nil
  end

  def start(entry_station)
    @entry_station = entry_station
  end

  def end_journey(exit_station)
    @exit_station = exit_station
  end

  def fare
    @entry_station && @exit_station ? MINIMUM_FARE : PENALTY_FARE
  end

end
