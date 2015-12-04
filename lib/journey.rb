class Journey

attr_reader :history_log, :current_journey, :complete

PENALTY_FARE = 6
MINIMUM_FARE = 1

def initialize
  @complete = false
  @history_log = []
  @current_journey = []
end

def start(entry_station)
  fresh_journey
  @complete = false
  @current_journey << entry_station
end

def end(exit_station)
  @complete = true
  @current_journey << exit_station
  fare
  log_history
end

def complete?
  @complete
end

def fare
  Journey::PENALTY_FARE
end

private

def fresh_journey
  @current_journey = [] if complete?
end


def log_history
  @history_log << @current_journey
end


end
