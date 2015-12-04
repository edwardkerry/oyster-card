
class JourneyLog

  attr_reader :log, :journey_klass, :journey
  alias_method :read, :log

  def initialize(journey_klass)
    @log = []
    @journey_klass = journey_klass
    @journey = journey_klass.new
  end

  def start_journey(station)
    write_journey if not_touched_out?
    new_journey
    journey.start(station)
  end

  def end_journey(station)
    journey.end_journey(station)
    write_journey
  end

  def charge
    journey.fare
  end

  def new_journey
    @journey = journey_klass.new
  end

# private

  def not_touched_out?
    journey.entry_station == !nil
  end

  def write_journey
    @log << journey
  end

end
