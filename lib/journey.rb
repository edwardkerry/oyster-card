class Journey

attr_reader :history_log, :current_journey, :complete

def initialize
  @complete = false
  @history_log = []
  @current_journey = []
end

def start(entry_station)
  @current_journey << entry_station
end

def end(exit_station)
  @current_journey << exit_station
  log_history
end

def complete?
  @complete
end

def log_history
  @history_log << @current_journey
  @current_journey = []
end


end
