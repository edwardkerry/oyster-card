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
      @entry_station && @exit_station ? calculate_fare : PENALTY_FARE
  end

  def calculate_fare
    diff = (entry_station.zone - exit_station.zone).abs
    MINIMUM_FARE + diff
  end

end
