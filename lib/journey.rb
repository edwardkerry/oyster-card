class Journey

  attr_reader :history_log, :current_journey, :entry_station, :exit_station, :PENALTY_FARE, :MINIMUM_FARE

  PENALTY_FARE = 6
  MINIMUM_FARE = 1

  def initialize
    @history_log = []
    @entry_station = nil
    @exit_station = nil
  end

  def start(entry_station)
    fresh_journey
    @entry_station = entry_station
  end

  def end_journey(exit_station)
    @exit_station = exit_station
  end

  def clear
    log_history
    fresh_journey
  end

  def fare
    @entry_station && @exit_station ? MINIMUM_FARE : PENALTY_FARE
  end

  private

  def fresh_journey
    @entry_station = nil
    @exit_station = nil
  end

  def log_history
    @history_log << self
  end

end
