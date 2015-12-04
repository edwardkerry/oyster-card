require 'journey_log'

describe JourneyLog do
  subject(:journey_log) { described_class.new(journey_klass)}
  let(:journey) { double :journey, entry_station: nil, start: nil, end_journey: nil }
  let(:journey1) { double :journey1 }
  let(:journey_klass) { double :journey_klass, new: journey }
  let(:station1) { double :station1 }
  let(:station2) { double :station2 }

  it 'returns an empty array by default' do
    expect(journey_log.read).to eq []
  end

  describe 'complete journey' do
    it 'should have a history log' do
      journey_log.start_journey(:station1)
      journey_log.end_journey(:station2)
      expect(journey_log.read).to eq [journey]
    end
  end
end
