class JourneyLog
  attr_reader :log
  alias_method :read, :log

  def initialize
    @log = []
  end

  def write journey
    @log << journey
  end
end
