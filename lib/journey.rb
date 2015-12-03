class Journey

attr_reader :history_log

def initialize
  @history_log = {}
  @current_journey = []
  @counter = 0
end

def start(entry_station)
  tracking
  @current_journey << entry_station
end

def end(exit_station)
  @current_journey << exit_station
  log_history
end

private

def log_history
  @history_log[@counter] = @current_journey
  @current_journey = []
end

def tracking
  @counter += 1
end

end
