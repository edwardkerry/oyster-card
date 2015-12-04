require 'journey_log'

describe JourneyLog do
  subject(:journey_log) { described_class.new }
  let(:journey) { double :journey }
  let(:journey1) { double :journey1 }
  let(:journey2) { double :journey2 }

  it 'returns an empty array by default' do
    expect(journey_log.read).to eq []
  end

  it 'returns the log of journeys' do
    journey_log.write(journey)
    expect(journey_log.read).to eq [journey]
  end

  describe 'complete journey' do
    it 'should have a history log' do
      journey_log.write(journey)
      journey_log.write(journey1)
      journey_log.write(journey2)
      expect(journey_log.read[1]).to eq journey1
    end
  end
end
